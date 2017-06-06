class MailAddressesController < ApplicationController
  SUBJECT  = "論文検索システム Escapism です." 

  def new
    @mail = MailAddress.new
  end

  def create
    @mail = MailAddress.new({address: params[:address]})
    if @mail.save
      flash[:now] = "メールを送信したので、そちらの URI からアクセスください" 
      send_email(params[:address])
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
