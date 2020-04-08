class AddRegionToAreas < ActiveRecord::Migration[5.2]
  def change
    change_table :areas do |t|
      t.integer :region, null: false, default: 0
    end
  end
end
