# 論文データの挿入
# ThesisInserter.new.upsertAll!

require 'find'

class ThisisImporter::ThesisInserter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def upsert_all!
    Find.find(THESIS_ROOT_DIRECTORY) do |path|
     if path =~ /.*\.pdf$/
       tex_path = path.gsub(/pdf$/, "tex")
        if File.exist?(tex_path) && !(Thesis.exists? url: path)
          thesis = upsert(path, tex_path)
          lines = ThisisImporter::PlaneThisis.new(path).lines
          insert_into_elasticsearch(thesis.id, lines)
        end
      end
    end
  end

  private

    def upsert(path, tex_path)
      # メタデータの取得
      authorData = "unknown"
      titleData  = "notitle"
      dateData   = "unknown"
      yearData   = "unknown"
      File.open(tex_path) do |file|
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
      
      create_thesis(titleData, authorData, yearData, dateData, path)
    end

    def create_thesis(title_data, author_data, year_data, date_data, path)
      author = Author.find_by name: author_data
      if !author
        author = Author.create name: author_data
      end

      if year_data != "unknown"
        thesis = Thesis.create title: title_data, year: year_data, url: path, author_id: author.id
      else
        thesis = Thesis.create title: title_data, year: date_data, url: path, author_id: author.id
      end
    end

    def insert_into_elasticsearch(thesis_id, text)
      CLIENT.index index: INDEX, type: TYPE, id: thesis_id, body: { 
        text: text
      }
    end
end
