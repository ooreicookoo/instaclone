class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :feed_id

      t.timestamps
    end
    add_index :favorites, :user_id
    add_index :favorites, :feed_id
    add_index :favorites, [:user_id, :feed_id], unique: true
  end
end
