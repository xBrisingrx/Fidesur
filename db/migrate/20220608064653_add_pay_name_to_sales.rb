class AddPayNameToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :land_fee_payments, :pay_name, :string
    add_column :sales_payments, :pay_name, :string
  end
end
