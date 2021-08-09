class CreateBatchPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :batch_payments do |t|
      t.integer :number, null: false
      t.decimal :money, precision: 15, scale: 2, default: 0, null: false
      t.decimal :total, precision: 15, scale: 2, default: 0
      t.boolean :active, default: true
      t.date :due_date
      t.date :pay_date
      t.boolean :payed, default: false
      t.references :sale, foreign_key: true
      t.timestamps
    end
  end
end
