# == Schema Information
#
# Table name: labo_people
#
#  id               :integer          not null, primary key
#  labo_id          :integer
#  year             :integer
#  gender           :integer
#  number_of_people :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_labo_people_on_labo_id  (labo_id)
#

require 'rails_helper'

RSpec.describe LaboPerson, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
