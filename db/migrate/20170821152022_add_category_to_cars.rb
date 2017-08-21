class AddCategoryToCars < ActiveRecord::Migration[5.1]
  def change
    add_reference :cars, :category, foreign_key: true
  end
end
