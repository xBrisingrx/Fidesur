class CreateProjectProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :project_providers do |t|
      t.references :project, foreign_key: true
      t.references :provider, foreign_key: true
      t.references :user_created, foreign_key: { to_table: 'users' }
      t.references :user_updated, foreign_key: { to_table: 'users' }
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
