# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Author < ApplicationRecord
  has_many :theses
  validates :name, length: { in: 1..15 }
end
