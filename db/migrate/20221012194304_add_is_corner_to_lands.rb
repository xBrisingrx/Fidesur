class AddIsCornerToLands < ActiveRecord::Migration[5.2]
  def change
    add_column :lands, :is_corner, :boolean, default: false
  end
end
