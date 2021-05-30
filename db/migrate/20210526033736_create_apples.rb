class CreateApples < ActiveRecord::Migration[5.2]
  def change
    create_table :apples do |t|
      t.string :code
      t.integer :hectares
      t.string :location
      t.float :value, :default => 0.0
      t.boolean :active, :default => true
      t.references :sector, foreign_key: true
      t.timestamps
    end
  end
end
