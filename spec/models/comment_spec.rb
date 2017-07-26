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

require 'rails_helper'

RSpec.describe Comment, type: :model do
end
