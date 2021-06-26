class ChangeDueDateToSale < ActiveRecord::Migration[5.2]
  def change
    change_column :sales, :due_date, :integer
  end
end
