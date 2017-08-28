class AddCleaningReferenceToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :cleaning, foreign_key: true
  end
end
