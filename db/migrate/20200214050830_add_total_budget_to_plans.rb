class AddTotalBudgetToPlans < ActiveRecord::Migration[5.2]
  def change
    change_table :plans do |t|
      t.integer :total_budget, null: false, default: 0
    end
    add_index :plans, :total_budget
  end
end
