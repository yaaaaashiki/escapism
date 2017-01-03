class SearchController < ApplicationController
  # 開発環境のみログインなし
  if Rails.env == 'development' then
    skip_before_filter :require_login
  end

  def index
    if params['q'] then
      @theses = Thesis.new.search(params['q'])
    end
  end
end
