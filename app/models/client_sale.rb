# == Schema Information
#
# Table name: client_sales
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint
#  sale_id    :bigint
#
# Indexes
#
#  index_client_sales_on_client_id  (client_id)
#  index_client_sales_on_sale_id    (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (sale_id => sales.id)
#
class ClientSale < ApplicationRecord
  belongs_to :client
  belongs_to :sale

  validates :client_id, uniqueness: { scope: :sale_id, message: "El cliente ya se encuentra registrado en esta venta" }
end
