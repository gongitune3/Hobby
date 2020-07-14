class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.integer :user_id
      t.string :title
      t.text :introduction
      t.integer :image_id
      t.timestamps
    end
  end
end
