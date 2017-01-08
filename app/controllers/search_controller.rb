class SearchController < ApplicationController
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  # 開発環境のみログインなし
  if Rails.env == 'development'
    skip_before_filter :require_login
  end

  def index
    if params[:q]
      response = search params[:q]
      @total = response["hits"]["total"] #response[:hits][:total]じゃ動かない？？？？

      thesisArray = []
      response["hits"]["hits"].each do |t|
        thesis = Thesis.find t["_id"]
        thesis = {thesis: thesis, body: t["_source"]["text"]}
        thesisArray.push thesis
      end
      @thesisArray = Kaminari.paginate_array(thesisArray).page(params[:page]).per(4)
    end
  end

  private
    def search(keyword = "")
      response = CLIENT.search index: INDEX, body: {
        query: {
          multi_match: {
            query: keyword,
            fields: ["text"]
          }
        },
        sort: { _score: { order: "desc" } } # 検索結果の一致度の降順でソート
        # Elasticsearchから返す検索結果の数をいじりたいときは以下を使用
        # from: page * PAGE_SIZE,  # 返す検索結果の開始位置(0が最初)
        # size: PAGE_SIZE   # 返す検索結果の数
      }
    end
end
