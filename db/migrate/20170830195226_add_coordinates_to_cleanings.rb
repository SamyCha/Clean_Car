class AddCoordinatesToCleanings < ActiveRecord::Migration[5.1]
  def change
    add_column :cleanings, :latitude, :float
    add_column :cleanings, :longitude, :float
  end
end
