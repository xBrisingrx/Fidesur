class CreateLandFeePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :land_fee_payments do |t|
      t.references :land_fee, foreign_key: true
      t.date :pay_date
      t.decimal :payment, precision: 15, scale: 2, default: 0.0
      t.text :comment
      t.boolean :active, default: 1
      t.timestamps
    end
  end
end
