class Labos::ChatroomsController < ApplicationController
  def index 
    @labo = Labo.find_by_id(params[:lab_id]) if params[:lab_id]
    if @labo.nil?
      render_404
      return
    end
    @messages = Message.all
    @users = User.all
  end
end
