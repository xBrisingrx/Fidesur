# == Schema Information
#
# Table name: sales_payments
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  detail         :string(255)
#  pay_name       :string(255)
#  tomado_en      :decimal(15, 2)   default(0.0), not null
#  value          :decimal(15, 2)   default(0.0), not null
#  value_in_pesos :decimal(15, 2)   default(0.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  currency_id    :bigint
#  sale_id        :bigint
#
# Indexes
#
#  index_sales_payments_on_currency_id  (currency_id)
#  index_sales_payments_on_sale_id      (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (sale_id => sales.id)
#
class SalesPayment < ApplicationRecord
  belongs_to :sale
  belongs_to :currency
  has_many_attached :images
  
end
