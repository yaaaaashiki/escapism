# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  year             :integer
#  email            :string(255)      not null
#  labo             :integer
#  role             :integer
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :comments
  belongs_to :labos

  validates :username, presence: true, uniqueness: true, length: { in: 1..10 }
  validates :year, presence: true
  validates :email, presence: true, uniqueness: true
  validates :crypted_password, presence: true
  validates :salt, presence: true
end
