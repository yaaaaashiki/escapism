# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  body       :text(4294967295)
#  summary    :text(65535)
#  title      :text(65535)
#  url        :text(65535)
#  year       :integer
#  labo_id    :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  access     :integer          default("0"), not null
#
# Indexes
#
#  index_theses_on_author_id  (author_id)
#  index_theses_on_labo_id    (labo_id)
#

class Thesis < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  is_impressionable
  belongs_to :author
  belongs_to :labo
  has_many :comments

  validates :title, presence: true
  validates :url, presence: true, uniqueness: true
  validates :year, presence: true
  validates :labo_id, presence: true
  validates :author_id, presence: true

  @@SEARCH_BY_BODY = "0"
  @@SEARCH_BY_TITLE = "1"

  @@LABO_THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data/ignore')
  #@@YHESIS_DIRECTORY_PAR_YEAR = %w[2014theses 2015theses 2016theses]
  @@YHESIS_DIRECTORY_PAR_YEAR = %w[2016theses]
  index_name "thesis_#{Rails.env}"
  settings do
    mappings dynamic: 'false' do
      indexes :id, index: 'not_analyzed'
      indexes :body, analyzer: 'kuromoji'
      indexes :summary, index: 'not_analyzed'
      indexes :title, analyzer: 'kuromoji'
      indexes :url, index: 'not_analyzed'
      indexes :year, index: 'not_analyzed'
      indexes :labo_id, index: 'not_analyzed'
      indexes :author_id, index: 'not_analyzed'
      indexes :labo do
        indexes :name, index: 'not_analyzed'
      end

      indexes :author do
        indexes :name, index: 'not_analyzed'
      end
    end
  end

  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(:id, :body, :summary, :title, :url, :year, :labo_id, :author_id)
      .merge(labo: { name: labo.name })
      .merge(author: { name: author.name })
  end

  def self.search_by_keyword(keyword, labo_id, field)
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        if keyword.present?
          multi_match {
            query keyword
            operator 'and'

            if field == @@SEARCH_BY_BODY
              fields %W{ body }
            elsif field == @@SEARCH_BY_TITLE
              fields %W{ title }
            end
          }
        else
          match_all
        end
      }

      sort { 
        by "_score", order: "desc"
      }

      if labo_id.to_i != Labo.NO_LABO_ID
        filter {
          term labo_id: labo_id.to_i
        }
      end
    }
    
    __elasticsearch__.search(search_definition)
  end

  def self.more_like_this(thesis_id)
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        more_like_this {
          fields %W{ title body }
          like [
            {_id: thesis_id}
          ]
        }
      }
    }
    
    __elasticsearch__.search(search_definition)
  end

  def self.extract_body(absolute_thesis_path)
    data = Yomu.new(absolute_thesis_path)
    body = data.text.unicode_normalize(:nfkc)
    body.gsub(/\r\n|\n|\r/, "")
  end

  def self.LABO_THESIS_ROOT_DIRECTORY
    @@LABO_THESIS_ROOT_DIRECTORY
  end

  def self.LABO_2016_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2016theses').join('contents')
  end

  def self.LABO_2015_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2015theses').join('contents')
  end

  def self.LABO_2014_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2014theses').join('contents')
  end

  def self.SEARCH_BY_BODY
    @@SEARCH_BY_BODY
  end 

  def self.SEARCH_BY_TITLE
    @@SEARCH_BY_TITLE
  end

  def self.YHESIS_DIRECTORY_PAR_YEAR
    @@YHESIS_DIRECTORY_PAR_YEAR
  end

  def self.bulk_save_from_admin_theses_new(year, labo_id, directory, number_of_registration, theses_information)
    theses = []
    labo = Labo.find labo_id

    number_of_registration.to_i.times do |i|
      thesis_meta_data = theses_information[i.to_s]
      author = Author.find_or_create_by name: thesis_meta_data[:author_name]

      thesis_absolute_pash = ''
      directory.each do |file|
        if file.headers.include? thesis_meta_data[:url]
          # NOTE:Labo.LABO_HASH[labo.name]使うよりデータベースに研究室の英名を入れたほうが使いやすい気がする
          thesis_absolute_pash = (@@LABO_THESIS_ROOT_DIRECTORY + year + 'contents' + Labo.LABO_HASH[labo.name] + thesis_meta_data[:url].sub(/(.*?)\//, "")).to_s
          thesis_absolute_dir = thesis_absolute_pash.sub(/\/[^\/]*$/, '')
          FileUtils.mkdir_p thesis_absolute_dir if Dir.exists?(thesis_absolute_dir) == false
          FileUtils.cp file.path, thesis_absolute_pash
          break
        end
      end

      thesis = Thesis.new
      thesis.year = year
      thesis.title = thesis_meta_data[:title]
      thesis.url = thesis_absolute_pash
      thesis.labo_id = labo.id
      thesis.author_id = author.id
      thesis.body = extract_body thesis_absolute_pash

      # TODO: MAKE NEXT TWO LINES DRY!! (以下の2行がthesis_importerと重複してるけど許して(*ﾉω・*)ﾃﾍ)
      summariser_name = String(Rails.root.join('lib/abstractor/abstract_creator.py'))
      thesis.summary, err, status = Open3.capture3("python3 " + summariser_name + " " + thesis_absolute_pash)

      theses << thesis
    end

    Thesis.import theses
    Thesis.__elasticsearch__.import
  end

  def self.crate_index_html(year, labo_id, number_of_registration, theses_information)
    # NOTE: テンプレートを外部ファイルにしたほうがいいけどどこに置く？？？？？
    # しかもslimじゃないwww
    template = <<TEMPLATE
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title><%= year %>年度<%= labo.name %>研究室修士・卒業論文</title>

  <style>
    body{
      margin: 3em 5%;
    }

    table{
      border-collapse: collapse;
      empty-cells: show;
    }

    table,th,td{
      border: solid thin black;
    }

    th{
      color:white;
      background-color:black;
    }

    th,td{
      padding: 0.3em;
    }
  </style>
</head>
<body>
  <h1><%= year %>年度<%= labo.name %>研究室修士・卒業論文</h1>

  <table summary="<%= year %>年度<%= labo.name %>研究室卒業論文・修士論文">
    <thead>
      <tr>
        <th>学位</th>
        <th>氏名</th>
        <th>論文</th>
        <th>その他</th>
      </tr>
    </thead>
    
    <% number_of_registration.to_i.times do |i| %>
      <tr>
        <td>TODO: 学士 or 修士を頑張ってだす</td>
        <td><%= theses_information[i.to_s][:author_name] %></td>
        <td>
          <a href="<%= theses_information[i.to_s][:url].sub(/(.*?)\\//, '') %>">
            <%= theses_information[i.to_s][:title] %>
          </a>
        </td>
        <td>
          <% theses_information[i.to_s][:others][:number_of_registration].to_i.times do |j| %>
            <a href="<%= theses_information[i.to_s][:others][j.to_s][:url].sub(/(.*?)\\//, '') %>">
              <%= theses_information[i.to_s][:others][j.to_s][:name] %>
            </a>
            <% if j < (theses_information[i.to_s][:others][:number_of_registration].to_i - 1) %>
              ・
            <% end %>
          <% end %>
        </td>
      </tr>
    <% end %>
  </table>
</body>
</html>
TEMPLATE

    labo = Labo.find labo_id
    
    erb = ERB.new template, nil, "%"
    contents = erb.result binding

    thesis_absolute_pash = @@LABO_THESIS_ROOT_DIRECTORY + year + 'contents' + Labo.LABO_HASH[labo.name] + 'index.html'
    File.open(thesis_absolute_pash, "w") do |f| 
      f.puts contents
    end

    thesis_absolute_pash
  end

  def belongs_to_martin_labo?
    url.include?("durst")
  end

  def belongs_to_harada_labo?
    url.include?("harada")
  end

  def belongs_to_sakuta_labo?
    url.include?("sakuta")
  end

  def belongs_to_sakuta_bachelor_thesis?
    url.include?("sakuta") && url.include?("undergraduate")
  end

  def belongs_to_yamaguchi_labo?
    url.include?("yamaguchi")
  end
end
