# == Schema Information
#
# Table name: mail_addresses
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MailAddress < ApplicationRecord
#  validate :blank_address
#  validate :address_form
#  validate :aoyama_address
  
#production 環境では上記正規表現. develop は作業用にバリなしで

  has_many :tokens

  def blank_address
    errors[:base] << "please input mail address" if address.blank?
  end

  def address_form
    errors[:base] << "not mail address form" unless address.match(/.*@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*/)
  end

  def aoyama_address
    errors[:base] << "not aoyama mail address form" unless address.match(/[a|c]5(?:6|8)1\d(?:0|1)\d{2}@aoyama.jp/)
  end
end
