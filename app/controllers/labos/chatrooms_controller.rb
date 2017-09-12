class Labos::ChatroomsController < ApplicationController
  def index 
    @labo = Labo.find_by_id(params[:id]) if params[:id]
    if @labo.nil?
      render_404
      return
    end
    @messages = Message.all
    @users = User.all
  end
end
