class AddTypeToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :type, :boolean, default: false, null: false
  end
end
