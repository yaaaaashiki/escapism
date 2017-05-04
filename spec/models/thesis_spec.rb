# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  title      :text(65535)
#  url        :text(65535)
#  year       :integer
#  labo_id    :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_theses_on_author_id  (author_id)
#  index_theses_on_labo_id    (labo_id)
#

require 'rails_helper'

RSpec.describe Thesis, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
