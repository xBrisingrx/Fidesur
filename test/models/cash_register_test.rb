# == Schema Information
#
# Table name: cash_registers
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  activity   :integer
#  comment    :text(65535)
#  detail     :text(65535)
#  product    :integer
#  value      :decimal(15, 2)   default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class CashRegisterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
