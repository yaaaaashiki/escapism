# == Schema Information
#
# Table name: labo_properties
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
#  index_labo_properties_on_labo_id  (labo_id)
#

class LaboProperty < ApplicationRecord
end
