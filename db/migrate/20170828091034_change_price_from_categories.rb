class ChangePriceFromCategories < ActiveRecord::Migration[5.1]
  def change
    change_column :categories, :price, :integer, default: 0, null: false
    rename_column :categories, :price, :price_cents
  end
end
