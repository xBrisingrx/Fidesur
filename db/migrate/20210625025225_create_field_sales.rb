class CreateFieldSales < ActiveRecord::Migration[5.2]
  def change
    create_table :field_sales do |t|
      t.references :field, foreign_key: true
      t.references :sale, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
