class AddUserTokensToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_token, :string
  end
end
