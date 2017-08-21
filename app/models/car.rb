class Car < ApplicationRecord
  belongs_to :user
  has_many :cleanings
end
