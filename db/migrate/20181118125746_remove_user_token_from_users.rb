class RemoveUserTokenFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_token, :string
    add_column :users, :encrypted_password, :string, null: false, default: ""
  end
end
