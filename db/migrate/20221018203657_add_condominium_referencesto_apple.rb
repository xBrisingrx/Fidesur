class AddCondominiumReferencestoApple < ActiveRecord::Migration[5.2]
  def change
    add_reference :apples, :condominium, foreign_key: true, default: 1
  end
end
