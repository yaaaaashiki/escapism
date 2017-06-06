class MailAddressesController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  SUBJECT  = "論文検索システム Escapism です"

  def new
    @mail = MailAddress.new
  end

  def create
    if MailAddress.create(address: params[:address][:name]).valid?
      flash[:now] = "メールを送信したので、そちらの URI からアクセスください" 
      send_email(params[:address][:name])
      redirect_to root_path
    else
      flash[:error] = "error" 
      redirect_to root_path
    end
  end

  def send_email(address)
    Admin::InviteUserMailer.invite(address, SUBJECT).deliver  
  end
end
