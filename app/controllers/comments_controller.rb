class CommentsController < ApplicationController
  MAX_LINES = 10

  def create
    @thesis = Thesis.find(params[:thesis_id])
    if @thesis.nil?
      logger.error("Internal server error: CommentsController create action 3 lines: @theses is undefined")
      render_500
    end

    if multiple_lines?(trim_multiple_newlines(comment_params[:body]))
      redirect_to thesis_path(@thesis)
      return
    end

    @comment = @thesis.comments.create(body: trim_multiple_newlines(comment_params[:body]), user_id: session[:user_id])
    redirect_to thesis_path(@thesis)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def trim_multiple_newlines(comment)
      comment.gsub(/\R{2,}/,"\n")
    end

    def multiple_lines?(comment)
      if comment.scan(/\R/).size >= MAX_LINES
        return true
      end
      return false
    end
end
