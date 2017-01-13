# 以下データ挿入
# ThesisInserter.new.upsertAll!

require 'find'

class ThesisInserter
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def upsertAll!
    pathArray = fetchPathArray /.*\.pdf/

    pathArray.each do |path|
      texPath = path.match(/(.*)\.pdf/)[1] + ".tex"
      if File.exist?(texPath) &&  !(Thesis.exists? url: path)
        # メタデータの取得
        authorData = "unknown"
        titleData = "notitle"
        dateData = "unknown"
        yearData = "unknown"
        File.open(texPath) do |file|
          file.each_line do |line|
            match = line.match(/author\{(.*?)\}/)
            if authorData == "unknown" && match
              authorData = match[1]
            end

            match = line.match(/title\{(.*?)\}/)
            if match
              titleData = match[1]
            end

            match = line.match(/date\{(.*?)\}/)
            if match
              dateData = match[1]
            end

            match = line.match(/year\{(.*?)\}/)
            if match
              yearData = match[1]
            end
          end
        end

        text = extractText(path)
 
        # Active Recordでデータ挿入
        author = Author.find_by name: authorData
        if !author
          author = Author.create name: authorData
        end
        if yearData != "unknown"
          thesis = Thesis.create title: titleData, year: yearData, url: path, author_id: author.id
        else
          thesis = Thesis.create title: titleData, year: dateData, url: path, author_id: author.id
        end
        
        # Elasticsearchにデータ挿入
        CLIENT.index index: INDEX, type: TYPE, id: thesis.id, body: { 
          text: text
        }
      end
    end
  end

  private
  
  def fetchPathArray(pattern = "")
    pathArray = []
    Find.find(THESIS_ROOT_DIRECTORY) do |f|
      pathArray.push(f) if f =~ pattern
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
