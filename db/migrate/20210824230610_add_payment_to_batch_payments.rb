class AddPaymentToBatchPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :batch_payments, :owes, :decimal,precision: 15, scale: 2, default: 0.0
    add_column :batch_payments, :payment, :decimal,precision: 15, scale: 2, default: 0.0
    add_column :batch_payments, :comment, :text
    add_column :batch_payments, :interest, :decimal,precision: 15, scale: 2, default: 0.0
    add_column :batch_payments, :pay_status, :integer, default: 0
  end
end
