class Admin::InviteUserMailer < ApplicationMailer
  def invite(to, subject)
    token = generate_token
    @registraion_url = new_user_url + "/" + token 

    Token.create(token: token)
    mail(to: to, subject: subject)
  end

  def generate_token
    SecureRandom.urlsafe_base64(6)
  end
end
