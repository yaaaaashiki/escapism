class ThesesController < ApplicationController
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'

  def index
    @popular_theses = Thesis.all.order(access: :desc).limit(5)

    if params[:q]
      response = search_by_keyword(params[:q])
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

  def show
    @thesis = Thesis.find(params[:id])
    @author = Author.find(@thesis.author_id)
    if @thesis
      impressionist(@thesis)
      if @thesis.impressionist_count.nil?
        @thesis.update_attribute(:access, 0)
      else
        @thesis.update_attribute(:access, @thesis.impressionist_count)
      end
    end
  end

  def download
    thesis = Thesis.find params[:id]
    send_file(thesis.url, disposition: :inline)
  end

  private
    def search_by_keyword(keyword = "")
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

end
