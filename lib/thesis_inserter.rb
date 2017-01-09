# 以下データ挿入
# Thesis_i.new.upsertAll!

class ThesisInserter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def upsertAll!
    pathArray = fetchPathArray

    pathArray.each do |path|
      text = extractText(path)

      # TODO: 以下のデータの取得方法を考える
      # NOTE: ディテクトリのPATHから取るのが良いかも 
      author = Author.find_by name: "Martin J. Dürst"
      if !author
        author = Author.create name: "Martin J. Dürst"
      end
      thesis = Thesis.create year: 2016, url: path, author_id: author.id
      Comment.create body: "ハイッ！ミーナサァアアン！！オーハヨウゴザイマァアアアス！！コメントシテクダサイネッッ！！",
                  user_id: 1,
                  thesis_id: thesis.id

      CLIENT.index  index: INDEX, type: TYPE, id: thesis.id, body: { 
        text: text
      }
    end
  end

  private
  
  def fetchPathArray
    require 'find'

    pathArray = []
    Find.find(THESIS_ROOT_DIRECTORY) do |f|
      pathArray.push(f) if f =~ /.*\.pdf/
    end

    return pathArray
  end

  # pathにはURLも可
  def extractText(path)
    data = Yomu.new path

    rawText = data.text
    rawText.gsub(/\r\n|\n|\r/, "")
  end
end
