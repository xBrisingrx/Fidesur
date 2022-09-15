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
	has_many :sale_products
	
	has_many :land_fees

	has_many :fees #esto seria el reemplazo de land fees

	has_many :sales_payments

	has_many :clients, through: :client_sales
	has_many :fields, through: :field_sales

	accepts_nested_attributes_for :sale_products, :client_sales

	before_create :set_attributes 

	def set_attributes
		self.sale_date = Time.now.strftime("%Y/%m/%d") if self.sale_date.blank? 
		self.due_date = 10 if self.due_date.blank? 
	end
	
	def calculate_total_paid!
		self.update( paid: self.get_primer_pago )
	end

	def calculate_total_value!
		# Se calcula el valor final de la venta, al momento de vender el lote
		# total_value = self.sales_payments.sum(:value_in_pesos) + self.land_fees.sum(:total_value)
		valor_venta = self.fees.sum(:total_value)
		self.update( total_cost: valor_venta )
	end

	def generar_cuotas number_cuota_increase, valor_cuota_aumentada, valor_cuota
  	aumenta_cuota = ( number_cuota_increase > 0 ) && ( valor_cuota_aumentada > 0 )
  	due_date = Time.new(self.sale_date.year, self.sale_date.month, self.due_date)

    for i in 1..self.number_of_payments
      # genero mis cuotas
      due_date += 1.month
      # El valor de la cuota puede ser que cambie , el valor total incrementa
      if aumenta_cuota && i >= number_cuota_increase
        value = valor_cuota_aumentada
      else
        value = valor_cuota
      end

      self.fees.create!(
      	due_date: due_date, 
        value: value, 
        number: i, 
        owes: value, 
        total_value: value
      )
    end
	end # generar cuota

	def total_pagado
		self.fees.where(payed: true).sum(:payment)
	end

	def get_primer_pago
		self.fees.where(number: 0).first.payment
	end

end