class AddReferencesUsersToFields < ActiveRecord::Migration[5.2]
  def change
    add_reference :fields, :user_created, foreign_key: { to_table: 'users' }, default: 1
    add_reference :fields, :user_updated, foreign_key: { to_table: 'users' }, default: 1
  end
end
