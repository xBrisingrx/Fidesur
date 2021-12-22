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
	validates :payment, numericality: { greater_than: 0,  message: 'El pago debe ser mayor a cero' }, on: :update
	
	enum pay_status: [:pendiente, :pagado, :pago_parcial]

	def expired?
		self.due_date.strftime("%F")  < Time.new.strftime("%F") 
	end

	def apply_arrear?
		self.expired? && self.sale.apply_arrear
	end

	def get_deuda
		LandFee.where(sale_id: self.sale_id).where('number < ?', self.number).where('owes > 0').sum('owes')
	end


	def pago_deuda
		puts "\n ========================  entramos al pago deuda ============================= \n"
		# Se pago el valor total de la cuota (valor cuota + ajuste + intereses ) 
		# y la deuda parcial o total que se tenia de cuotas anteriores
		puts "============== payment #{self.payment} valor total #{self.total_value}"
		monto = self.payment - self.total_value
		puts "\n =============== mi monto es #{monto.class} \n"
		deuda = LandFee.where(sale_id: self.sale_id).where('number < ?', self.number).where('owes > 0').order('id ASC')
		puts "---------- cuotas encontradas => #{deuda.count} "
		deuda.each do |d|
			puts "\n START each ============> #{d.owes} <<- #{d.owes.class}"
			if monto > 0
				puts "\n ------------------ monto => #{monto} dedua #{d.owes}"
				if monto <= d.owes 
					d.owes -= monto 
					monto -= d.owes 
				else
					d.owes = 0.0 
					monto -= d.owes 
				end # end if resto deuda
			end # end if check monto > 0
			puts "\n FIN each ============> #{d.owes}"
			if d.owes == 0
				d.pay_status = :pagado
			end
			d.save!
		end # end each deudas
	end

end
