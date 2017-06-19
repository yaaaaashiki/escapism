class ThesesController < ApplicationController
  THESIS_ROOT_DIRECTORY = Rails.root.join('thesis_data')
  CLIENT = Elasticsearch::Client.new log: true
  INDEX = 'thesis_development'
  TYPE = 'thesis'
  NO_LABO_ID = 9

  before_action :init_set_popular_theses

  def index
    @author = Author.all
    @labo_id = params[:l]
    @query = params[:q]


    thesisArray = []

    if @labo_id && @query != ""
      response = search_by_keyword(@query)
      response["hits"]["hits"].each do |t|
        unless @labo_id.to_i == NO_LABO_ID
          thesis = Thesis.find_by(id: t["_id"], labo_id: @labo_id)
        else
          thesis = Thesis.find_by(id: t["_id"])
        end
      if thesis
          thesis = {thesis: thesis, body: t["_source"]["text"]}
          thesisArray.push(thesis)
        end
      end
     @thesisArray = Kaminari.paginate_array(thesisArray).page(params[:page]).per(4)
    elsif @query != ""
      response = search_by_keyword(@query)
      response["hits"]["hits"].each do |t|
      thesis = Thesis.find(t["_id"])
        if thesis
          thesis = {thesis: thesis, body: t["_source"]["text"]}
          thesisArray.push(thesis)
        end
      end
     @thesisArray = Kaminari.paginate_array(thesisArray).page(params[:page]).per(4)
    elsif @labo_id
      @thesisArray = Kaminari.paginate_array(search_by_labo_id(@labo_id)).page(params[:page]).per(4)
    end

    @labos = Labo.all
  end

  def show
    @popular_theses = Thesis.all.order(access: :desc).limit(5)
    @thesis = Thesis.find(params[:id])
    @author = Author.find(@thesis.author_id)
    if @thesis
      impressionist(@thesis)
      if @thesis.impressionist_count.nil?
        @thesis.update_attribute(:access, 0)
      else
        @thesis.update_attribute(:access, @thesis.impressionist_count(:filter=>:all))
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

    def search_by_labo_id(id)
      thesisArray = []
      @theses = Thesis.where(labo_id: id)
      @theses.each do |t|
        result = search_by_thesis_id(t)
        thesis = {thesis: t, body: result["hits"]["hits"].first["_source"]["text"]}
        thesisArray.push(thesis)
      end
      thesisArray
    end

    def search_by_thesis_id(thesis_id)
      CLIENT.search(index: INDEX, body:{
        query: {
          terms: {"_id": [thesis_id]}
        }
      })
    end

    def init_set_popular_theses
      @popular_theses = Thesis.all.order(access: :desc).limit(5)
    end

end
