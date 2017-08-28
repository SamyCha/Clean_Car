class Cleaning < ApplicationRecord
  belongs_to :user
  belongs_to :car

  def price
    car.category.price
  end
end
