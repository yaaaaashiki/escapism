class SearchController < ApplicationController
  # 開発環境のみログインなし
  if Rails.env == 'development'
    skip_before_filter :require_login
  end

  def index
    if params[:q] 
      @theses = Thesis.new.search(params[:q])
    end
  end
end
