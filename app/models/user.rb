# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  year             :integer
#  email            :string(255)      not null
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :comments
  validates :password, length: { minimum: 7 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :username, :year,:email, presence: true
  validates :email, uniqueness: true


end
