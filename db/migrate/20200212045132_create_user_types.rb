class CreateUserTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :user_types do |t|
      t.integer :tens_place_age, null: false, index: true
      t.integer :early_or_late, null: false, index: true
      t.integer :standard_budget, null: false
      t.index %i[tens_place_age early_or_late], unique: true

      t.timestamps
    end
  end
end
