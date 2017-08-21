class AddCarToCleanings < ActiveRecord::Migration[5.1]
  def change
    add_reference :cleanings, :car, foreign_key: true
  end
end
