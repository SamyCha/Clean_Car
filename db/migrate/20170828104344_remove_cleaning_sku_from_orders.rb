class RemoveCleaningSkuFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :cleaning_sku, :string
  end
end
