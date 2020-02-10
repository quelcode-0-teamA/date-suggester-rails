class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :budget, null: false
      t.string :tel
      t.string :url

      t.timestamps
    end
  end
end
