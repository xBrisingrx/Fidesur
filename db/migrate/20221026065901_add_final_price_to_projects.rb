class AddFinalPriceToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :final_price, :decimal
  end
end
