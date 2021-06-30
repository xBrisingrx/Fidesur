class ChangeHectaresToApples < ActiveRecord::Migration[5.2]
  def change
  	change_column :apples, :hectares, :decimal, precision: 15, scale: 2, default: 0
  end
end
