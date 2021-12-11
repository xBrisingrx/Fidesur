class AddAjusteToBatchPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :batch_payments, :ajuste, :decimal, precision: 15, scale: 2, default: 0
  end
end
