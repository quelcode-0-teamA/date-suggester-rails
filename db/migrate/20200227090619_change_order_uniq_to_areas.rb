class ChangeOrderUniqToAreas < ActiveRecord::Migration[5.2]
  def up
    remove_index :areas, :order
    add_index    :areas, :order
    change_column :areas, :order, :integer, null: false, default: 0
  end

  def down
    remove_index :areas, :order
    add_index    :areas, :order
    change_column :areas, :order, :integer, null: false
  end
end
