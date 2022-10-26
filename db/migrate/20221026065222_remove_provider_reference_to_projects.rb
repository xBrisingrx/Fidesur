class RemoveProviderReferenceToProjects < ActiveRecord::Migration[5.2]
  def change
    remove_column :projects, :provider_id, foreign_key: true
  end
end
