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
  has_one :word_count

  @@SEARCH_BY_BODY = "0"
  @@SEARCH_BY_TITLE = "1"

  @@LABO_THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data/ignore')
  index_name "thesis_#{Rails.env}"
  settings do
    mappings dynamic: 'false' do
      indexes :id, index: 'not_analyzed'
      indexes :body, analyzer: 'kuromoji'
      indexes :title, analyzer: 'kuromoji'
      indexes :url, index: 'not_analyzed'
      indexes :year, index: 'not_analyzed'
      indexes :labo_id, index: 'not_analyzed'
      indexes :author_id, index: 'not_analyzed'
    end
  end

  def as_indexed_json(options = {})
    attributes
      .symbolize_keys
      .slice(:id, :body, :title, :url, :year, :labo_id, :author_id)
  end

  def self.search_by_keyword(keyword, labo_id, field)
    search_definition = Elasticsearch::DSL::Search.search {
      query {
        if keyword.present?
          multi_match {
            query keyword

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

  def self.extract_body(absolute_thesis_path)
    data = Yomu.new(absolute_thesis_path)
    body = data.text
    body.gsub(/\r\n|\n|\r/, "")
  end

  def self.LABO_THESIS_ROOT_DIRECTORY
    @@LABO_THESIS_ROOT_DIRECTORY
  end

  def self.LABO_2016_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2016theses')
  end

  def self.LABO_2015_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2015theses')
  end

  def self.LABO_2014_THESES
    @@LABO_THESIS_ROOT_DIRECTORY.join('2014theses')
  end

  def self.SEARCH_BY_BODY
    @@SEARCH_BY_BODY
  end 

  def self.SEARCH_BY_TITLE
    @@SEARCH_BY_TITLE
  end

  def belongs_to_martin_labo?
    url.include?("duerst")
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
end
