class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 7 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :username, :year,:email, presence: true
  validates :email, uniqueness: true
end
