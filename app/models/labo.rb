# == Schema Information
#
# Table name: labos
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  features   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Labo < ApplicationRecord
  @@SYMBOL_LABO_NAMES = %i(sumi duerst sakuta ohara komiyama tobe harada lopez )
  @@ARRAY_LABO_DIRECTORY_NAMES = %w(duerst harada komiyama lopez ohara sakuta sumi tobe ) # yamaguchi)
  @@ARRAY_LABO_NAMES = ['鷲見研究室', 'Dürst 研究室', '佐久田研究室', '大原研究室', '小宮山研究室', '戸辺研究室', '原田研究室', 'lopez 研究室']
  @@NO_LABO_ID = 9

  has_many :users
  has_many :theses
  serialize :features

  def self.NO_LABO_ID
    @@NO_LABO_ID
  end

  def self.ARRAY_LABO_NAMES
    @@ARRAY_LABO_NAMES
  end

  def self.ARRAY_LABO_DIRECTORY_NAMES
    @@ARRAY_LABO_DIRECTORY_NAMES
  end

  def self.parse_labo_name(path)
    if path.include?("duerst")
      'Dürst 研究室'
    elsif path.include?("harada")
      '原田研究室'
    elsif path.include?("komiyama")
      '小宮山研究室'
    elsif path.include?("lopez")
      'lopez 研究室'
    elsif path.include?("ohara")
      '大原研究室'
    elsif path.include?("sakuta")
      '佐久田研究室'
    elsif path.include?("sumi")
      '鷲見研究室'
    elsif path.include?("tobe")
      '戸辺研究室'
    end
  end
end
