class CreateClientFields < ActiveRecord::Migration[5.2]
  def change
    create_table :client_fields do |t|
      t.references :client, foreign_key: true
      t.references :field, foreign_key: true
      t.text :detail
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end
