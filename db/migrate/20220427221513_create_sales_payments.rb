class CreateSalesPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_payments do |t|
      t.decimal :value, precision: 15, scale: 2, default: 0, null: false
      t.decimal :tomado_en, precision: 15, scale: 2, default: 0, null: false, commnet: 'A que valor se tomo la moneda'
      t.decimal :value_in_pesos, precision: 15, scale: 2, default: 0, null: false
      t.string :detail
      t.references :sale, foreign_key: true
      t.references :currency, foreign_key: true
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
