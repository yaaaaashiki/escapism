# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
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

require 'date'

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :comments
  belongs_to :labos

  validates :username, presence: true, uniqueness: true, length: { in: 1..10 }
  validates :email, presence: true, uniqueness: true
  validates :crypted_password, presence: true
  validates :salt, presence: true
  validate :role_presence
  after_validation :remove_unnecessary_error_messages

  LABO_STUDENT = 1
  NONE_LABO_STUDENT = 2
  MARCH = 3

  def get_role_name
    self.role == LABO_STUDENT ? "研究生" : "学生"
  end

  def labo_student?
    self.role == LABO_STUDENT
  end

  def belongs_to_this_labo?(room_id)
    self.labo == room_id
  end

  def role_presence
    errors[:base] << "研究室への所属有無を選択してください。" unless role.to_i == NONE_LABO_STUDENT || role.to_i == LABO_STUDENT
  end

  def remove_unnecessary_error_messages
    if errors.messages.include?(:crypted_password) || errors.messages.include?(:salt)
      errors.messages.delete(:crypted_password)
      errors.messages.delete(:salt)
      errors[:base] << "パスワードを入力してください。"
    end
  end
end
