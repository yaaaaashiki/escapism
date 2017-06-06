# == Schema Information
#
# Table name: mails
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Mail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
