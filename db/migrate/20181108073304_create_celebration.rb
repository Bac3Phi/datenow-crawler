class CreateCelebration < ActiveRecord::Migration[5.0]
  def change
    create_table :celebrations do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.date :date_celebration
      t.string :note
    
      t.timestamps
    end
  end
end
