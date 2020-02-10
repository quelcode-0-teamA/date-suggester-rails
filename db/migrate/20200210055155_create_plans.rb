class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.references :area, foreign_key: true, null: false

      t.timestamps
    end
  end
end
