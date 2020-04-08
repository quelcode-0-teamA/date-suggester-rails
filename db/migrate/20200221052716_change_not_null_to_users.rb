class ChangeNotNullToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column_null :users, :email, true
    change_column_null :users, :password_digest, true
    change_column_null :users, :gender, true
  end

  def down
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :gender, false
  end
end
