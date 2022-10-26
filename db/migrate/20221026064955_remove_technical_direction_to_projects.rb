class RemoveTechnicalDirectionToProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :tecnical_direction
  end
end
