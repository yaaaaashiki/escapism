# == Schema Information
#
# Table name: mail_addresses
#
#  id         :integer          not null, primary key
#  address    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_mail_addresses_on_address  (address) UNIQUE
#

FactoryGirl.define do

  factory :mail_address, class: MailAddress do
    address "c5617146@aoyama.jp"
  end

  factory :b_it_aoyama_address, class: MailAddress do
    address "a5813088@aoyama.jp"
  end

  factory :m_it_aoyama_address, class: MailAddress do
    address "c5617149@aoyama.jp"
  end

  factory :gmail_address, class: MailAddress do
    address "yashiki@gmail.com"
  end

  factory :yahoo_address, class: MailAddress do
    address "yashiki@yahoo.com"
  end

  factory :blank_address, class: MailAddress do
    address ""
  end

  factory :m_not_science_and_technology_aoyama_address, class: MailAddress do
    address "c4613088@aoyama.jp"
  end

  factory :b_not_science_and_technology_aoyama_address, class: MailAddress do
    address "a4813088@aoyama.jp"
  end

  factory :m_physics_aoyama_address, class: MailAddress do
    address "c5113088@aoyama.jp"
  end

  factory :b_physics_aoyama_address, class: MailAddress do
    address "a5113088@aoyama.jp"
  end

  factory :m_management_aoyama_address, class: MailAddress do
    address "c5713088@aoyama.jp"
  end

  factory :b_management_aoyama_address, class: MailAddress do
    address "a5113088@aoyama.jp"
  end

  factory :m_it_9digit_aoyama_address, class: MailAddress do
    address "c56171466@aoyama.jp"
  end

  factory :b_it_9digit_aoyama_address, class: MailAddress do
    address "a58130888@aoyama.jp"
  end

  factory :b_it_domain_typo1, class: MailAddress do
    address "a5813088@aoama.jp"
  end

  factory :b_it_domain_typo2, class: MailAddress do
    address "a5813088@aoyamajp"
  end

  factory :b_it_domain_typo3, class: MailAddress do
    address "a5813088@aoyama..jp"
  end

  factory :b_it_domain_typo4, class: MailAddress do
    address "a5813088@aoyama.cm"
  end

end
