class DeleteSpaceNotAvailabletoField < ActiveRecord::Migration[5.2]
  def change
    remove_column :fields, :space_not_available
  end
end
