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

require 'date'

class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :comments
  belongs_to :labos

  validates :username, presence: true, uniqueness: true, length: { in: 1..10 }
  validates :year, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, length: { in: 1..2 }
  validates :crypted_password, presence: true
  validates :salt, presence: true

  LABO_STUDENT = 1
  NONE_LABO_STUDENT = 2
  THIRD_YEAR = 3

  def set_role
    Date.today.year - self.year >= THIRD_YEAR ? LABO_STUDENT : NONE_LABO_STUDENT
  end

  def get_role_name
    self.role == LABO_STUDENT ? "研究生" : "学生"
  end

  def get_role_id
    self.role == LABO_STUDENT ? LABO_STUDENT : NONE_LABO_STUDENT
  end

   def labo_student?
      self.get_role_id == LABO_STUDENT
   end

   def belongs_to_this_labo?(room_id)
     self.labo == room_id
   end
end
