class Book < ApplicationRecord
  validates :isbn, presence: true
end
