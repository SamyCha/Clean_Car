class CreateCleanings < ActiveRecord::Migration[5.1]
  def change
    create_table :cleanings do |t|
      t.string :place
      t.datetime :period
      t.string :comment_access
      t.boolean :requirements
      t.integer :rating
      t.string :cleaning_status, default: "pending"
      t.string :images
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
