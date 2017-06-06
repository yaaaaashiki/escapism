# == Schema Information
#
# Table name: mail_addresses
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe MailAddress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
