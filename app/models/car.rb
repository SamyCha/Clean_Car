class Car < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :cleanings

  validates :immatriculation, presence: true, uniqueness: true, allow_blank: false
  validates :brand, presence: true, allow_blank: false
  validates :model, presence: true, allow_blank: false
  validates :color, presence: true, allow_blank: true
  validates :category_id, presence: true
end
