class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :number, null: false
      t.string :name
      t.string :tecnical_direction
      t.references :provider, foreign_key: true
      t.references :material, foreign_key: true
      t.references :project_type, foreign_key: true
      t.decimal :price, precision: 15, scale: 2, default: 0, null: false
      t.integer :status
      t.references :user_created, foreign_key: { to_table: 'users' }
      t.references :user_updated, foreign_key: { to_table: 'users' }
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
