class Order < ApplicationRecord
  belongs_to :cleaning
  monetize :amount_cents
end
