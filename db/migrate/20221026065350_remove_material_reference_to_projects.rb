class RemoveMaterialReferenceToProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :material_id, foreign_key: true
  end
end
