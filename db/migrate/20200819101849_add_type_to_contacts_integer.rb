class AddTypeToContactsInteger < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :type, :string, default: '0', null: false
    add_column :contacts, :reply, :boolean, default: false, null: false
  end
end
