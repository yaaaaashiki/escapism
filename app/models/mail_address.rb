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
  #validates :address, format: {with: /^[a|c]5(?:6|8)1\d(?:0|1)\d{2}@aoyama.jp/}

  #production 環境では下記正規表現. developは作業用にバリなしで
  #/^[a|c]5(?:6|8)1\d(?:0|1)\d{2}@aoyama.jp/
end
