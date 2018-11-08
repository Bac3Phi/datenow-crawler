class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :avatar
      t.string :lover_name
      t.string :lover_avatar
      t.date   :start_date

      t.timestamps
    end
  end
end
