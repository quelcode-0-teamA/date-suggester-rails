class ChangeDataBudgetToSpots < ActiveRecord::Migration[5.2]
  def up
    change_column :spots, :budget, 'integer USING CAST(budget AS integer)'
  end

  def down
    change_column :spots, :budget, :string
  end
end
