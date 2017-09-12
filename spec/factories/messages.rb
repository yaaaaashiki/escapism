# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :message do
    content "MyText"
  end
end
