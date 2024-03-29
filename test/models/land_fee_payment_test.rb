# == Schema Information
#
# Table name: land_fee_payments
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  comment     :text(65535)
#  pay_date    :date
#  pay_name    :string(255)
#  payment     :decimal(15, 2)   default(0.0)
#  tomado_en   :decimal(15, 2)   default(0.0), not null
#  total       :decimal(15, 2)   default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  currency_id :bigint
#  land_fee_id :bigint
#
# Indexes
#
#  index_land_fee_payments_on_currency_id  (currency_id)
#  index_land_fee_payments_on_land_fee_id  (land_fee_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (land_fee_id => land_fees.id)
#
require 'test_helper'

class LandFeePaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
