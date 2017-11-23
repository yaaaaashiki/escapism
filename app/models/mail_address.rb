# == Schema Information
#
# Table name: mail_addresses
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mail_addresses_on_address  (address) UNIQUE
#

class MailAddress < ApplicationRecord
  before_validation :convert_addrss_to_half_lower_case
  validate :aoyama_address
  validate :unique_address
  
  has_many :tokens

  def aoyama_address
    errors[:base] << "青山メールのアドレスを入力してください。" unless address.match(/(?:c56|a58)\d{2}(?:0|1)\d{2}@aoyama(?:\.ac)?\.jp/)
  end

  def unique_address
    index = address.index('@')
    if !index.nil?
      username = address.slice(0..index)
      short_address = username + "aoyama.jp"
      long_address = username + "aoyama.ac.jp"
      errors[:base] << "そのアドレスは既に使用されています．" unless !MailAddress.exists?(address: long_address) && !MailAddress.exists?(address: short_address)
    end
  end

  def convert_addrss_to_half_lower_case
    if address.present?
      address.downcase!
      address.tr!('０-９ａ-ｚ', '0-9a-z')
    end
  end
end
