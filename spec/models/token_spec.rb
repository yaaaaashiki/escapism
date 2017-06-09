# == Schema Information
#
# Table name: tokens
#
#  id              :integer          not null, primary key
#  mail_address_id :integer
#  token           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_tokens_on_mail_address_id  (mail_address_id)
#

require 'rails_helper'

RSpec.describe Token, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
