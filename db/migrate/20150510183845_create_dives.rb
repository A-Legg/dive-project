class CreateDives < ActiveRecord::Migration
  def change
    create_table :dives do |t|
      t.string :location
      t.date :date
      t.time :length
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :dives, :user_id
  end
end
