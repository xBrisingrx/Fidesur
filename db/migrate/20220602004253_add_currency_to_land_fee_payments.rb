class AddCurrencyToLandFeePayments < ActiveRecord::Migration[5.2]
  def change
    add_column :land_fee_payments, :tomado_en, :decimal, precision: 15, scale: 2, default: 0, null: false, commnet: 'A que valor se tomo la moneda'
    add_column :land_fee_payments, :total, :decimal, precision: 15, scale: 2, default: 0, null: false, commnet: 'Calculo del valor total ingresado'
    add_reference :land_fee_payments, :currency, foreign_key: true
  end
end
