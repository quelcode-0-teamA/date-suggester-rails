class CreateDateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :date_types do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
