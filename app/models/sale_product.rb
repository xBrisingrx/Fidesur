# == Schema Information
#
# Table name: sale_products
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  comment      :text(65535)
#  product_type :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_id   :bigint
#  sale_id      :bigint
#
# Indexes
#
#  index_sale_products_on_product_type_and_product_id  (product_type,product_id)
#  index_sale_products_on_sale_id                      (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product, polymorphic: true

  after_create :update_product_status
  after_destroy :free_product

  def update_product_status
    case self.product_type
      when 'Land'
        product = Land.find self.product_id
        product.update(status: :bought)
      else 
        raise "model sale_product: producto no reconocido"
    end
  end

  def free_product
    case self.product_type
      when 'Land'
        product = Land.find self.product_id
        product.update(status: :available)
      else 
        raise "model sale_product: producto no reconocido"
    end
  end
  
end
