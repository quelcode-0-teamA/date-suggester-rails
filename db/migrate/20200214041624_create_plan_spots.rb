class CreatePlanSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_spots do |t|
      t.references :plan, foreign_key: true, null: false, index: true
      t.references :spot, foreign_key: true, null: false
      t.integer :order, null: false
      t.index %i[plan_id spot_id], unique: true
      t.index %i[plan_id order], unique: true

      t.timestamps
    end
  end
end
