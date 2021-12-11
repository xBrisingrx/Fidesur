class AddAjusteToField < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :ajuste, :decimal, precision: 15, scale: 2, default: 0
  end
end
