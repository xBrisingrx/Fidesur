class CreateClientSales < ActiveRecord::Migration[5.2]
  def change
    create_table :client_sales do |t|
      t.references :client, foreign_key: true
      t.references :sale, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
