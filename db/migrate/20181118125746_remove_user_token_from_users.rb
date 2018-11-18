class RemoveUserTokenFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :user_token, :string
  end
end
