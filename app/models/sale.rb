# == Schema Information
#
# Table name: sales
#
#  id                 :bigint           not null, primary key
#  active             :boolean          default(TRUE)
#  apply_arrear       :boolean
#  arrear             :integer
#  comment            :text(65535)
#  due_date           :integer
#  number_of_payments :integer
#  paid               :decimal(15, 2)   default(0.0)
#  total_cost         :decimal(15, 2)   default(0.0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Sale < ApplicationRecord
	has_many :client_sales
	has_many :field_sales
	has_many :batch_payments

	has_many :clients, through: :client_sales
	has_many :fields, through: :field_sales
end
