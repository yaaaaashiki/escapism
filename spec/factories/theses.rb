# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  url        :text(65535)
#  year       :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_theses_on_author_id  (author_id)
#

FactoryGirl.define do
  factory :thesis do
    url "MyText"
    year 1
  end
end
