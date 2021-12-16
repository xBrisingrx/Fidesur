class AddSaleDateToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :sale_date, :date
  end
end
