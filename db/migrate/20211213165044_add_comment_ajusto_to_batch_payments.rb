class AddCommentAjustoToBatchPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :batch_payments, :comment_ajuste, :text
  end
end
