class AddColsToProjectProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :project_providers, :iva, :decimal
    add_column :project_providers, :price, :decimal, comment: "Lo que cobra"
    add_column :project_providers, :price_calculate, :decimal, comment: "Precio calculado cuando el proveedor cobra por porcentaje de obra"
    add_column :project_providers, :porcent, :decimal, comment: "Porcentaje que representa el proveedor en el costo del proyecto"
  end
end
