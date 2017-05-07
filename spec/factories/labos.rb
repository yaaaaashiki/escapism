# == Schema Information
#
# Table name: labos
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  features   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :labo do
    
  end
end
