class CreateSectors < ActiveRecord::Migration[5.2]
  def change
    create_table :sectors do |t|
      t.string :name
      t.integer :size
      t.boolean :active, :default => true
      t.timestamps
    end
  end
end
