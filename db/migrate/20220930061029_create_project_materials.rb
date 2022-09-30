class CreateProjectMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :project_materials do |t|
      t.references :project, foreign_key: true
      t.references :material, foreign_key: true
      t.references :user_created, foreign_key: { to_table: 'users' }
      t.references :user_updated, foreign_key: { to_table: 'users' }
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
