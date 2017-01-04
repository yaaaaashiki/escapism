class Thesis
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def search(keyword = "")
    response = CLIENT.search index: INDEX, body: {
      query: {
        multi_match: {
          query: keyword,
          fields: ["author", "year", "text"]
        }
      },
      sort: { _score: { order: "desc" } } # 検索結果の一致度の降順でソート
      # Elasticsearchから返す検索結果の数をいじりたいときは以下を使用
      # from: page * PAGE_SIZE,  # 返す検索結果の開始位置(0が最初)
      # size: PAGE_SIZE   # 返す検索結果の数
    }
    Hashie::Mash.new response
  end

  def upsert!(url, argQuery = {})
    tempQuery = {author: nil, year: nil, comment: nil, text: nil}.merge(argQuery)

    # Elsticsearchのマッピングを崩さないためにクエリを再構築
    query = {}
    query[:url]     = url # urlはElasticsearchのidに使用するので不変
    query[:author]  = tempQuery[:author]  if tempQuery[:author]
    query[:year]    = tempQuery[:year]    if tempQuery[:year]
    query[:comment] = tempQuery[:comment] if tempQuery[:comment]
    query[:text]    = tempQuery[:text]    if tempQuery[:text]

    CLIENT.index  index: INDEX, type: TYPE, id: url, body: query
  end

  def upsertAll!
    pathArray = fetchPathArray

    pathArray.each do |path|
      text = extractText(path)

      # TODO: 以下のデータの取得方法を考える
      # NOTE: ディテクトリのPATHから取るのが良いかも
      query = { 
        author:  "Martin J. Dürst",
        year:    2016,
        comment: "ハイッ！ミーナサァアアン！！オーハヨウゴザイマァアアアス！！コメントシテクダサイネッッ！！",
        url:     path,
        text:    text
      }
      upsert! path, query
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
