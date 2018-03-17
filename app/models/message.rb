# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  user_id    :integer
#  labo_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_labo_id  (labo_id)
#  index_messages_on_user_id  (user_id)
#

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :labo
  validates :body, length: { in: 1..400 }

  def belongs_to_labo?(lab_id)
    self.labo_id == lab_id
  end
end