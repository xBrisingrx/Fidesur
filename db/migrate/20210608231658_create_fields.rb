class CreateFields < ActiveRecord::Migration[5.2]
  def change
    create_table :fields do |t|
      t.string :code, commnet: 'denominacion'
      t.string :measures
      t.decimal :surface, precision: 15, scale: 2, default: 0
      t.string :ubication
      t.decimal :price, precision: 15, scale: 2, default: 0
      t.integer :status, default: 0
      t.references :apple, foreign_key: true
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
