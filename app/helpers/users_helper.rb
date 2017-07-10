module UsersHelper
  def generate_token
    token = SecureRandom.urlsafe_base64(6)
  end
end
