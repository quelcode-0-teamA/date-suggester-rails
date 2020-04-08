class ChangeTelOfSpot < ActiveRecord::Migration[5.2]
  def up
    change_column :spots, :tel, 'integer USING CAST(tel AS integer)'
  end

  def down
    change_column :spots, :tel, :string
  end
end
