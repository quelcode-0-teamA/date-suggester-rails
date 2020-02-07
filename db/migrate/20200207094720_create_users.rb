class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
      t.string :token, null: false, index: { unique: true }
      t.string :name
      t.integer :birth_year, null: false
      t.integer :gender, null: false
      t.references :area, foreign_key: true, null: false

      t.timestamps
    end
  end
end
