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
  describe "Validation" do
    context "success" do
      it "is valid at bachlor it aoyama user" do
        email = build(:b_it_aoyama_address)
        expect(email).to be_valid
      end

      it "is valid at master it aoyama user" do
        email = build(:m_it_aoyama_address)
        expect(email).to be_valid
      end
    end

    context "faild" do
      it "is not valid with gmail address" do
          email = build(:gmail_address)
          expect(email).not_to be_valid
      end

      it "is not valid with yahoo address" do
        email = build(:yahoo_address)
        expect(email).not_to be_valid
      end

      it "is not valid with blank address" do
        email = build(:blank_address)
        expect(email).not_to be_valid
      end

      it "is not valid with master not science and technology aoyama address" do
        email = build(:m_not_science_and_technology_aoyama_address)
        expect(email).not_to be_valid
      end

      it "is not valid with bachlor not science and technology aoyama address" do
        email = build(:b_not_science_and_technology_aoyama_address)
        expect(email).not_to be_valid
      end

      it "is not valid with master physics aoyama address" do
          email = build(:m_physics_aoyama_address)
          expect(email).not_to be_valid
      end

      it "is not valid with bachlor physics aoyama address" do
          email = build(:b_physics_aoyama_address)
          expect(email).not_to be_valid
      end

      it "is not valid with master physics aoyama address" do
          email = build(:m_management_aoyama_address)
          expect(email).not_to be_valid
      end

      it "is not valid with bachlor management aoyama address" do
        email = build(:b_management_aoyama_address)
        expect(email).not_to be_valid
      end

      it "is not valid with 9 digit master it aoyama address" do
          email = build(:m_it_9digit_aoyama_address)
          expect(email).not_to be_valid
      end

      it "is not valid with 9 digit bachlor it aoyama address" do
          email = build(:b_it_9digit_aoyama_address)
          expect(email).not_to be_valid
      end

      it "is not valid with bachlor it domain typo part 1" do
        email = build(:b_it_domain_typo1)
        expect(email).not_to be_valid
      end

      it "is not valid with bachlor it domain typo part 2" do
        email = build(:b_it_domain_typo2)
        expect(email).not_to be_valid
      end

      it "is not valid with bachlor it domain typo part 3" do
        email = build(:b_it_domain_typo3)
        expect(email).not_to be_valid
      end

      it "is not valid with bachlor it domain typo part 4" do
        email = build(:b_it_domain_typo4)
        expect(email).not_to be_valid
      end
    end
  end
end
