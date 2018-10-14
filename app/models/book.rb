class Book < ApplicationRecord
    validates :title,       presence: true
    validates :isbn,        presence: true
end
