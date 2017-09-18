# == Schema Information
#
# Table name: labos
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  features         :text(65535)
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

FactoryGirl.define do
  factory :labo do
    
  end
end
