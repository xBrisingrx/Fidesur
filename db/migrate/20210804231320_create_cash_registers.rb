class CreateCashRegisters < ActiveRecord::Migration[5.2]
  def change
    create_table :cash_registers do |t|
      t.integer :product
      t.integer :activity
      t.decimal :value, precision: 15, scale: 2, default: 0
      t.text :detail
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
