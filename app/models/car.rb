class Car < ApplicationRecord
  belongs_to :user
  has_many :cleanings
  has_one :category

  validates :immatriculation, presence: true, uniqueness: true, allow_blank: false
  validates :brand, presence: true, allow_blank: false
  validates :model, presence: true, allow_blank: false
  validates :color, allow_blank: true
end
