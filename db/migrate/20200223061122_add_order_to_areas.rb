class AddOrderToAreas < ActiveRecord::Migration[5.2]
  def change
    change_table :areas do |t|
      t.integer :order, null: false
      t.index :order, unique: true
    end
  end
end
