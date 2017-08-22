class Car < ApplicationRecord
  belongs_to :user
  has_many :cleanings
  has_one :category
end
