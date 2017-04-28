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

FactoryGirl.define do
  factory :user do
    username "user1"
    year 2016
    email "yaaaaaakishi@gmail.com"
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_name_user, class: User do
    year 2016
    email "noname@gmail.com"
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_mail_user, class: User do
    username "nomailuser"
    year 2016
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end
end
