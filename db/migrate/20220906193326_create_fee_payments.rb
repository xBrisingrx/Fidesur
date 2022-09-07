class CreateFeePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :fee_payments do |t|
      t.references :fee, foreign_key: true
      t.date :pay_date
      t.references :currency, foreign_key: true
      t.decimal :payment, precision: 15, scale: 2, default: 0.0
      t.decimal :tomado_en, precision: 15, scale: 2, default: 1, commnet: 'A que valor se tomo la moneda'
      t.decimal :total, precision: 15, scale: 2, default: 0, commnet: 'Calculo del valor total ingresado'
      t.text :comment, default: ''
      t.boolean :active, default: true
      
      t.timestamps
    end
  end
end