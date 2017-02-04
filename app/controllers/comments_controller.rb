class CommentsController < ApplicationController
  def create
    @thesis = Thesis.find params[:thesis_id] 
    @comment = @thesis.comments.create(comment_params)
    redirect_to thesis_path(@thesis) 
  end
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
