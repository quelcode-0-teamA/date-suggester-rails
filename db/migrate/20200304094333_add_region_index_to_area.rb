class AddRegionIndexToArea < ActiveRecord::Migration[5.2]
  def change
    add_index :areas, :region
  end
end
