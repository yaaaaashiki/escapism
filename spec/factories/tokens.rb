# == Schema Information
#
# Table name: tokens
#
#  id              :integer          not null, primary key
#  mail_address_id :integer
#  token           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tokens_on_mail_address_id  (mail_address_id)
#

FactoryGirl.define do
  factory :token do
    token "token123"
  end

  factory :token_with_mail_id, class: Token do
    token "hoge1123"
    mail_address_id 1
  end
end
