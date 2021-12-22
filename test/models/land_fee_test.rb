# == Schema Information
#
# Table name: land_fees
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  adjust         :decimal(15, 2)   default(0.0)
#  comment        :text(65535)
#  comment_adjust :text(65535)
#  due_date       :date
#  fee_value      :decimal(15, 2)   default(0.0), not null
#  interest       :decimal(15, 2)   default(0.0)
#  number         :integer          not null
#  owes           :decimal(15, 2)   default(0.0)
#  pay_date       :date
#  pay_status     :integer          default("pendiente")
#  payed          :boolean          default(FALSE)
#  payment        :decimal(15, 2)   default(0.0)
#  total_value    :decimal(15, 2)   default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  sale_id        :bigint
#
# Indexes
#
#  index_land_fees_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
require 'test_helper'

class LandFeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
