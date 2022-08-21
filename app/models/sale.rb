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
#  sale_date          :date
#  total_cost         :decimal(15, 2)   default(0.0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Sale < ApplicationRecord
	has_many :client_sales
	has_many :field_sales
	has_many :land_fees
	has_many :sales_payments

	has_many :clients, through: :client_sales
	has_many :fields, through: :field_sales

	def calculate_total_paid!
		total_paid = self.sales_payments.sum(:value_in_pesos)
		self.update( paid: total_paid )
	end

	def calculate_total_value!
		# Se calcula el valor final de la venta, al momento de vender el lote
		total_value = self.sales_payments.sum(:value_in_pesos) + self.land_fees.sum(:total_value)
		self.update( total_cost: total_value )
	end
end
