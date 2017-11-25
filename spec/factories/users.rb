# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  email            :string(255)      not null
#  labo             :integer
#  role             :integer
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
    username "user_1"
    email "yaaaaaakishi@gmail.com"
    labo 1
    role 2
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_name_user, class: User do
    email "noname@gmail.com"
    labo 2
    role 2
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_mail_user, class: User do
    username "no_mail"
    labo 3
    role 2
    salt "asdasdastr4325234324sdfds"
    crypted_password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_labo_user, class: User do
    username "no_labo"
    email "c5617146@aoyama.com"
    role 2
    salt "asdasdastr4325234324sdfds"
    password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :no_password_user, class: User do
    username "no_pass"
    email "c5617146@aoyama.com"
    labo 2
    role 2
    salt "asdasdastr4325234324sdfds"
  end

  factory :it_aoyama_user, class: User do
    username "it_aoyama"
    email "c5617146@aoyama.com"
    labo 2
    role 2
    salt "asdasdastr4325234324sdfds"
    password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  #For creating user_controller's user_params testdata
  #This hash should be fourth field.
  factory :post_params_it_aoyama_user, class: User do
    username "it_aoyama"
    email "c5617146@aoyama.jp"
    labo Labo::NO_LABO_ID
    role User::NONE_LABO_STUDENT
    password "password"
  end

  factory :post_params_no_name_user, class: User do
    email "noname@gmail.com"
    password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end

  factory :post_params_no_mail_user, class: User do
    username "no_mail"
    password Sorcery::CryptoProviders::BCrypt.encrypt("password", "asdasdastr4325234324sdfds")
  end
end
