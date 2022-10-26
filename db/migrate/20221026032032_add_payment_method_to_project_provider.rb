class AddPaymentMethodToProjectProvider < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_providers, :payment_methods, foreign_key: true
  end
end
