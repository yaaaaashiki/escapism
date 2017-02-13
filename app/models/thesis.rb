# == Schema Information
#
# Table name: theses
#
#  id         :integer          not null, primary key
#  title      :text(65535)
#  url        :text(65535)
#  year       :integer
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
  has_many :comments

  def self.create_from_seed(title_data, author_data, year_data, date_data, path)
    ActiveRecord::Base.transaction do 
      author = Author.find_or_create_by(name: author_data)

      year = year_data == "unknown" ? date_data : year_data
      Thesis.create!(title: title_data, year: year, url: path, author_id: author.id)
    end
  end
end
