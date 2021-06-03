class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :code, comment: "Legajo"
      t.string :name
      t.string :last_name
      t.integer :dni
      t.string :cuil
      t.string :email
      t.string :phone
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
