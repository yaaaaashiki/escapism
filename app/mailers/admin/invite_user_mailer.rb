class Admin::InviteUserMailer < ApplicationMailer
  def invite(to, subject)
    token = generate_token
    @registraion_url = new_user_url + "/" + token 

    Token.create(token: token)
    binding.pry
    Token.mail_address_id = Mailaddress.find(address: to)
    mail(to: to, subject: subject)
  end

  private
    def generate_token
      SecureRandom.urlsafe_base64(6)
    end
end
