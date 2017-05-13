class SearchController < ApplicationController
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def index
    if params[:labo_id]
      respond_to do |format|
        if params[:labo_id]
          create_result_by_labo_id
          format.js
        end
        format.html
      end
    end

    if params[:q]
      response = search(params[:q])
      thesisArray = []
      response["hits"]["hits"].each do |t|
        if params[:l]
          thesis = Thesis.find_by(id: t["_id"], labo_id: params[:l])
        else
          thesis = Thesis.find(t["_id"])
        end

        if thesis
          thesis = {thesis: thesis, body: t["_source"]["text"]}
          thesisArray.push(thesis)
        end
      end
      @thesisArray = Kaminari.paginate_array(thesisArray).page(params[:page]).per(4)
    end

    @labos = Labo.all
  end

  private
    def search(keyword = "")
      response = CLIENT.search(index: INDEX, body: {
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
      })
    end

    def create_result_by_labo_id
      thesisArray = []
      @theses = Thesis.where(labo_id: params[:labo_id])
      @theses.each do |t|
        result = search_by_thesis_id(t)
        thesis = {thesis: t, body: result["hits"]["hits"].first["_source"]["text"]}
        thesisArray.push(thesis)
      end
      @thesisArray = thesisArray
    end

    def search_by_thesis_id(thesis_id)
      CLIENT.search(index: INDEX, body:{
        query: {
          terms: {"_id": [thesis_id]}
        }
      })
    end

end
