# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  title      :text(65535)
#  url        :text(65535)
#  year       :integer
#  labo       :integer
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_theses_on_author_id  (author_id)
#

class Thesis < ApplicationRecord
  belongs_to :author
  belongs_to :labo
  has_many :comments
  has_one :word_count

  def self.create_from_seed(attrs = {})
    ActiveRecord::Base.transaction do 
      author = Author.find_or_create_by(name: attrs[:author_name])

      if attrs[:year] == "unknown" 
        attrs[:year] = attrs[:date_data]
      end

      attrs[:author_id] = author.id
      attrs.delete(:author_name)
      attrs.delete(:date_data)
      Thesis.create!(attrs)
    end
  end
end
