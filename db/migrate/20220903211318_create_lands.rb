class CreateLands < ActiveRecord::Migration[5.2]
  def change
    create_table :lands do |t|
      t.string :code, commnet: 'denominacion'
      t.string :measures
      t.decimal :surface, precision: 15, scale: 2, default: 0
      t.string :ubication
      t.decimal :price, precision: 15, scale: 2, default: 0
      t.integer :status, default: 0
      t.integer :land_type, default: 0
      t.boolean :is_green_space, default: 0
      t.decimal :space_not_available,precision: 15, scale: 2, default: 0.0, comment: 'Espacio de el lote que no puede ser utilizado'
      t.references :apple, foreign_key: true
      t.references :user_created, foreign_key: { to_table: 'users' }
      t.references :user_updated, foreign_key: { to_table: 'users' }
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
