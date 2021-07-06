class AddSpaceNotAvailableToApple < ActiveRecord::Migration[5.2]
  def change
    add_column :apples, :space_not_available, :decimal,precision: 15, scale: 2, default: 0.0, comment: 'Espacio de la manzana que no puede ser utilizado'
  end
end
