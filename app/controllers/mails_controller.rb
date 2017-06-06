class MailsController < ApplicationController
  SUBJECT  = "論文検索システム Escapism です." 

  def new
    @mail = Mail.new
  end

  def create
    @mail = Mail.new(mail_params)
    if @mail.save
      flash[:now] = "メールを送信したので、そちらの URI からアクセスください" 
      send_email(params[:mail][:address])
      redirect_to root_path
    else
      flash[:error] = "error" 
      redirect_to root_path
    end
  end

  private

    def mail_params
      params.require(:mail).permit(:address)
    end

    def send_email(address)
      Admin::InviteUserMailer.invite(address, SUBJECT).deliver  
    end

end
