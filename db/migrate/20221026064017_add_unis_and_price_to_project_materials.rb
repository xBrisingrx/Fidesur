class AddUnisAndPriceToProjectMaterials < ActiveRecord::Migration[5.2]
  def change
    add_column :project_materials, :units, :integer
    add_column :project_materials, :price, :decimal
  end
end
