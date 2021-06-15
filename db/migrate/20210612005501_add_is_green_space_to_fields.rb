class AddIsGreenSpaceToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :is_green_space, :boolean, default: 0
  end
end
