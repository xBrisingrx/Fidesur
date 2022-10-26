# == Schema Information
#
# Table name: payment_methods
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  description :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PaymentMethod < ApplicationRecord
end
