class ThesesController < ApplicationController
  # 開発環境のみログインなし
  if Rails.env == 'development'
    skip_before_filter :require_login
  end

  def show
    @thesis   = Thesis.find params[:id]
    @author   = Author.find @thesis.author_id
    comments  = Comment.where thesis_id: @thesis.id
    @comentArray = []
    comments.each do |c|
      body = c[:body]
      commenter = User.find c.user_id
      comment = {comment: body, commenter: commenter}
      @comentArray.push comment
    end
  end

  def download
    thesis = Thesis.find params[:id]
    send_file(thesis.url, disposition: :inline)
  end
end
