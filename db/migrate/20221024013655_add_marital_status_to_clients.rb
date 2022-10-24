class AddMaritalStatusToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :marital_status, :string, default: 'Soltero'
  end
end
