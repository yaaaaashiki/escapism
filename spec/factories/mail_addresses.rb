# == Schema Information
#
# Table name: mail_addresses
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :mail_address do
    address "c5617146@aoyama.jp"
  end
end
