class RemoveTypeFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :type, :boolean
  end
end
