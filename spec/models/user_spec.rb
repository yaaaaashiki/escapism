# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  year             :integer
#  email            :string(255)      not null
#  labo             :integer
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    let(:username) { "username" }
    let(:year)     { 1 }
    let(:email)    { "emailaddress" }

    it "is valid with username and year and email" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is not valid without username" do
      user = User.new(
        year: year,
        email: email
      )
      expect(user).not_to be_valid
    end

    it "is not valid without year" do
      user = User.new(
        username: username,
        email: email
      )
      expect(user).not_to be_valid
    end

    it "is not valid without email" do
      user = User.new(
        username: username,
        year: year,
      )
      expect(user).not_to be_valid
    end
  end
end
