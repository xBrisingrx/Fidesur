class AddFieldTypeToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :field_type, :integer, default: 0
  end
end
