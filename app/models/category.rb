class Category < ApplicationRecord
  has_many :cars

  monetize :price_cents
end
