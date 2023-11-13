class CreateLineitems < ActiveRecord::Migration[7.1]
  def change
    create_table :lineitems do |t|
      t.integer :quantity
      t.references :product, null: false, foreign_key: true
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
