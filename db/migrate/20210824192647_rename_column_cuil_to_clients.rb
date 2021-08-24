class RenameColumnCuilToClients < ActiveRecord::Migration[5.2]
  def change
    rename_column :clients, :cuil, :direction
  end
end
