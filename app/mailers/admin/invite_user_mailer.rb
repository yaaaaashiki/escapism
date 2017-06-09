class Admin::InviteUserMailer < ApplicationMailer
  def invite(to, subject)
    token = generate_token
    @registraion_url = new_user_url + "/" + token 

    mail_address_id = MailAddress.find_by(address: to).id
    Token.create(token: token, mail_address_id: mail_address_id)
    mail(to: to, subject: subject)
  end

  private
    def generate_token
      SecureRandom.urlsafe_base64(6)
    end
end
