class Admin::InviteUserMailer < ApplicationMailer
  def invite(to, subject)
    body = "hoge"
    @registraion_url = new_user_url

    mail(
      to: to,
      subject: subject 
    )

#    mail(:to => to, :subject => subject) do |format|
#      format.text { render :text => body }
#    end
  end
end
