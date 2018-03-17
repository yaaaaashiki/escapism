class Labos::ChatroomsController < ApplicationController
  def index 
    @labo = Labo.find_by_id(params[:lab_id]) if params[:lab_id]
    if @labo.nil?
      render_404
      return
    end
    @message_users = ActiveRecord::Base.connection.select_all("select messages.labo_id, users.labo, users.username, messages.body, messages.created_at
                                                                from messages join users
                                                                on messages.user_id = users.id
                                                                where messages.labo_id = #{params[:lab_id]}
                                                              ").to_hash
  end
end