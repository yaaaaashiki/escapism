# == Schema Information
#
# Table name: labos
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  features         :text(65535)
#  crypted_password :string(32)       not null
#  salt             :string(32)       not null
#  string           :string(32)       not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Labo, type: :model do
end
