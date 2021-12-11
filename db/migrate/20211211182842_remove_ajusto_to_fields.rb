class RemoveAjustoToFields < ActiveRecord::Migration[5.2]
  def change
    remove_column :fields, :ajuste
  end
end
