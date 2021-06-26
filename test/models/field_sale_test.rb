# == Schema Information
#
# Table name: field_sales
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  field_id   :bigint
#  sale_id    :bigint
#
# Indexes
#
#  index_field_sales_on_field_id  (field_id)
#  index_field_sales_on_sale_id   (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (field_id => fields.id)
#  fk_rails_...  (sale_id => sales.id)
#
require 'test_helper'

class FieldSaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
