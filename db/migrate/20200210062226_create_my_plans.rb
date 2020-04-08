class CreateMyPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :my_plans do |t|
      t.references :user, foreign_key: true, null: false
      t.references :plan, foreign_key: true, null: false

      t.timestamps
    end
  end
end
