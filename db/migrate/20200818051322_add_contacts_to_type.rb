class AddContactsToType < ActiveRecord::Migration[5.2]
  def change
    add_column :types, :type, :boolean, default: false, null: false
  end
end
