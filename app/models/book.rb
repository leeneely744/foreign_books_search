class Book < ApplicationRecord
    validates :title,       presence: true
    validates :isbn,        presence: true
    validates :item_price,  presence: true
end
