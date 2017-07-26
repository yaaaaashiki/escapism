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
  describe "Mail address ID uniquness" do
    context "failed" do
      let!(:token) {create(:token_with_mail_id)}
      let(:mail) {create(:mail_address)}
      let(:test_token) {build(:token)}
      it "is not valid when there are same mail address id records" do
        test_token.mail_address_id = 1 
        expect(test_token).not_to be_valid
      end
    end
  end
end
