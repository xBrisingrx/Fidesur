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
class LandFee < ApplicationRecord
	# total_value es el valor que se deberia haber pagado ( sumamos el valor cuota + interes + ajuste )
	# fee_value es el valor de la cuota
	#number es el numero de cuota
	# payment es lo que se pago 
	# owes es lo que se adeuda de la cuota cuando se hace un pago parcial
	
	belongs_to :sale
	has_many :land_fee_payments

	#  hay que chequear este dato
	# validates :owes, numericality: { greater_than_or_equal_to: 0,  message: 'Lo adeudado no puede ser menor a cero' }, on: :update
	# validates :payment, numericality: { greater_than: 0,  message: 'El pago debe ser mayor a cero' }, on: :update
	validates :interest, :adjust, :payment, numericality: true
	validates :fee_value, numericality: { greater_than: 0,  message: 'El valor de la cuota debe ser mayor a cero' }
	
	enum pay_status: [:pendiente, :pagado, :pago_parcial]

	def expired?
		self.due_date.strftime("%F")  < Time.new.strftime("%F") 
	end

	def apply_arrear?
		self.expired? && self.sale.apply_arrear
	end

	def get_deuda
		LandFee.where(sale_id: self.sale_id).where('number < ?', self.number).where( 'due_date < ?', Time.new.strftime("%F") ).where('owes > 0').sum('owes')
	end

	def has_debt?
		self.get_deuda > 0
	end

	def aply_adjust adjust
		puts "\n\n\n\n\n ****************5 Aplicamos el ajuste a partir de la cuota #{self.number} \n"
		cuotas = LandFee.where(["sale_id = ? and number > ?", self.sale_id, self.number ])
		cuotas.each do |cuota|
			"\n Ajustamos en la cuota #{cuota.number} q tenia de ajuste #{cuota.adjust.to_f} \n"
			cuota.adjust += adjust
			cuota.total_value = cuota.fee_value + cuota.interest + cuota.adjust
			cuota.save
			"\n Update exitoso #{cuota.adjust.to_f}"
		end
	end

	def pago_supera_cuota payment, pay_date
		# payment = self.payment - self.total_value
		puts "\n ######### EXTRA #{payment.to_f} ######### \n"
		puts "\n ========================  Pago de otras cuotas ============================= \n"
		# Obtengo todas las cuotas que no estan pagadas distintas a la que se esta pagando en este momento
		cuotas_a_pagar = LandFee.where(sale_id: self.sale_id).where('number != ?', self.number).where('owes > 0').order('id ASC')
		puts "\n *** Cantidad de cuotas encontradas #{ cuotas_a_pagar.count } \n"
		cuotas_a_pagar.each do |cuota| 
			puts "\n Payment menor a cero => #{payment.to_f} \n" if payment <= 0.0
			return if payment <= 0.0
			puts "De la cuota #{ cuota.number } debe #{ cuota.owes.to_f }"
			# pago a registrar, se deja en cero el monto porque es para lleva el registro de adelantos/pago deuda
			pago = cuota.land_fee_payments.new(
				pay_date: pay_date, 
        payment: 0, 
        tomado_en: 1,
        total: 0,
        currency_id: 1)
			owes = cuota.owes #lo que se adeuda de esta cuota
			if payment < cuota.owes
				puts "\n *** #{cuota.id} "
				cuota.update!(owes: cuota.owes - payment, pay_status: :pago_parcial, payed: true )

				if cuota.due_date < pay_date 
					pago.comment = "Pago parcial de deuda de esta cuota por un monto de $#{payment.to_f}, realizado cuando se pago la cuota ##{self.number}" 
				else 
					pago.comment = "Se realizo un adelanto parcial de esta cuota por un monto de $#{payment.to_f}, cuando se pago la cuota ##{self.number}" 
				end
				puts "\n ===> payment #{payment} "
			else
				cuota.update!(owes: 0.0, pay_status: :pagado, payed: true)
				if cuota.due_date < pay_date 
					pago.comment = "Pago total de deuda de esta cuota por un monto de $#{owes.to_f}, realizado cuando se pago la cuota ##{self.number}" 
				else 
					pago.comment = "Se realizo un pago adelantado de esta cuota por un monto de $#{owes.to_f}, cuando se pago la cuota ##{self.number}" 
				end
			end # if payment <= cuota.owes

			pago.save!
			payment -= owes
		end # cuotas_a_pagar.each
	end # pago_supera_cuota
end
