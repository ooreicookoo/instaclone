class AddUserIdToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :user_id, :string
    add_index :favorites, :user_id
  end
end
