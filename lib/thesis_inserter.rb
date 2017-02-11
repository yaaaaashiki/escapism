# 論文データの挿入
# ThesisInserter.new.upsertAll!

require 'find'

class ThesisInserter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def upsertAll!
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
     if path =~ /.*\.pdf/
       texPath = path.match(/(.*)\.pdf/)[1] + ".tex"
        if File.exist?(texPath) && !(Thesis.exists? url: path)
          upsert path, texPath
        end
      end
    end
  end

  private

    def upsert(path, texPath)
      # メタデータの取得
      authorData = "unknown"
      titleData  = "notitle"
      dateData   = "unknown"
      yearData   = "unknown"
      File.open(texPath) do |file|
        file.each_line do |line|
          match = line.match(/author\{(.*?)\}/)
          authorData = match[1] if authorData == "unknown" && match

          match = line.match(/title\{(.*?)\}/)
          titleData  = match[1] if match
            
          match = line.match(/date\{(.*?)\}/)
          dateData   = match[1] if match

          match = line.match(/year\{(.*?)\}/)
          yearData   = match[1] if match
        end
      end
      
      thesis = createThesis titleData, authorData, yearData, dateData, path
      
      text = extractText path
      insertIntoElasticsearch thesis.id, text
    end

    def createThesis(titleData, authorData, yearData, dateData, path)
      author = Author.find_by name: authorData
      if !author
        author = Author.create name: authorData
      end

      if yearData != "unknown"
        thesis = Thesis.create title: titleData, year: yearData, url: path, author_id: author.id
      else
        thesis = Thesis.create title: titleData, year: dateData, url: path, author_id: author.id
      end
    end

    # pathにはURLも可
    def extractText(path)
      data = Yomu.new path

      rawText = data.text
      rawText.gsub(/\r\n|\n|\r/, "")
    end

    def insertIntoElasticsearch(thesisId, text)
      CLIENT.index index: INDEX, type: TYPE, id: thesisId, body: { 
        text: text
      }
    end
end
