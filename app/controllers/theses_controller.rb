class ThesesController < ApplicationController
  def show
    @thesis = Thesis.find params[:id]
    @author = Author.find @thesis.author_id
binding.pry
    #    current_user
  end

  def download
    thesis = Thesis.find params[:id]
    send_file(thesis.url, disposition: :inline)
  end
end
