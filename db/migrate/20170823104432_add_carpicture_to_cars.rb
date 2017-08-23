class AddCarpictureToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :car_picture, :string
  end
end
