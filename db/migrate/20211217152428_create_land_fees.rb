class CreateLandFees < ActiveRecord::Migration[5.2]
  def change
    create_table :land_fees do |t|
      t.references :sale, foreign_key: true
      t.integer :number, null: false
      t.decimal :fee_value, precision: 15, scale: 2, default: 0, null: false
      t.decimal :total_value, precision: 15, scale: 2, default: 0
      t.date :due_date
      t.date :pay_date
      t.decimal :owes, precision: 15, scale: 2, default: 0.0
      t.decimal :payment, precision: 15, scale: 2, default: 0.0
      t.text :comment
      t.decimal :interest, precision: 15, scale: 2, default: 0.0
      t.integer :pay_status,  default: 0
      t.decimal :adjust,  precision: 15, scale: 2, default: 0
      t.text :comment_adjust
      t.boolean :payed, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end

