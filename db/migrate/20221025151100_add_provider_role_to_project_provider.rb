class AddProviderRoleToProjectProvider < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_providers, :provider_roles, foreign_key: true
  end
end
