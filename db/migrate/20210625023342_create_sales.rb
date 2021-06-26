class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.decimal :paid, precision: 15, scale: 2, default: 0
      t.decimal :total_cost, precision: 15, scale: 2, default: 0
      t.integer :number_of_payments
      t.integer :arrear
      t.date :due_date
      t.boolean :apply_arrear
      t.text :comment
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
