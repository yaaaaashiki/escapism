class Comment < ApplicationRecord
  belongs_to :thesis
  belongs_to :user
end
