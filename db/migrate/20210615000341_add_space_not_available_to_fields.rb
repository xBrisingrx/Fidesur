class AddSpaceNotAvailableToFields < ActiveRecord::Migration[5.2]
  def change
    add_column :fields, :space_not_available, :decimal,precision: 15, scale: 2, default: 0.0, comment: 'Espacio de el lote que no puede ser utilizado'
  end
end
