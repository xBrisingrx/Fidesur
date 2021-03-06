# == Schema Information
#
# Table name: batch_payments
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  ajuste         :decimal(15, 2)   default(0.0)
#  comment        :text(65535)
#  comment_ajuste :text(65535)
#  due_date       :date
#  interest       :decimal(15, 2)   default(0.0)
#  money          :decimal(15, 2)   default(0.0), not null
#  number         :integer          not null
#  owes           :decimal(15, 2)   default(0.0)
#  pay_date       :date
#  pay_status     :integer          default("pendiente")
#  payed          :boolean          default(FALSE)
#  payment        :decimal(15, 2)   default(0.0)
#  total          :decimal(15, 2)   default(0.0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  sale_id        :bigint
#
# Indexes
#
#  index_batch_payments_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
class BatchPayment < ApplicationRecord

	# total es el valor que se deberia haber pagado ( sumamos el valor cuota + interes + ajuste )
	# money es el valor de la cuota
	# payment es lo que se pago 
	
	belongs_to :sale

	enum pay_status: [:pendiente, :pagado, :pago_parcial]

	def expired?
		self.due_date.strftime("%F")  < Time.new.strftime("%F") 
	end

	def apply_arrear?
		self.expired? && self.sale.apply_arrear
	end

end	
