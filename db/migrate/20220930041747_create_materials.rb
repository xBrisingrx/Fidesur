class CreateMaterials < ActiveRecord::Migration[5.2]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :description
      t.boolean :active, default: true
      t.references :user_created, foreign_key: { to_table: 'users' }
      t.references :user_updated, foreign_key: { to_table: 'users' }
      t.timestamps
    end
  end
end
