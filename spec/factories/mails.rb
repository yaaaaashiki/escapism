# == Schema Information
#
# Table name: mails
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :mail do
    email "MyString"
  end
end
