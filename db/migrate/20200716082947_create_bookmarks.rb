class CreateBookmarks < ActiveRecord::Migration[5.2]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.integer :board_id
      t.timestamps
      t.index [:user_id, :board_id], unique: true
    end
  end
end
