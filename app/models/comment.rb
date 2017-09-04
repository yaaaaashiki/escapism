# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  user_id    :integer
#  thesis_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_thesis_id  (thesis_id)
#  index_comments_on_user_id    (user_id)
#

class Comment < ApplicationRecord
  belongs_to :thesis
  belongs_to :user
  validates :body, length: { in: 1..400 }
  validates :user_id, presence: true
  validates :thesis_id, presence: true
end
