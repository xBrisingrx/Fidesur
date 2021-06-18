class ChangeSizeColumnToSectors < ActiveRecord::Migration[5.2]
  def change
    change_column :sectors, :size, :decimal, precision: 15, scale: 2, default: 0.0
  end
end
