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
class LandFeePayment < ApplicationRecord
	belongs_to :land_fee
	belongs_to :currency
	has_many_attached :images

	validates :payment, presence: true,numericality: true
	# validates :payment, numericality: { greater_than: 0,  message: 'El pago debe ser mayor a cero' }
	validates :pay_date, presence: true
	# validate :check_owes, on: :create 

	after_create :update_payment_land_fee

	def check_owes
		# El pago parcial de una cuota no puede ser mayor a lo adeudao
		# Si no tiene pagos significa que esta cuota todavia no se ha pagado 
		if ( self.land_fee.land_fee_payments.count > 0 ) && (self.land_fee.owes < self.payment.to_f)
			errors.add(:payment, "El valor ingresado es mayor al adeudado")
		end
	end

	def update_payment_land_fee
		puts "\n ########################### entramos al update_payment_land_fee \n"
		# actualizamos el monto pagado
		cuota = self.land_fee
		# Si el total pagado es 0.0 significa que son las cuotas que genero de adelanto o pago de deuda
		if cuota.land_fee_payments.count > 1 && self.total != 0.0
			puts "\n\n pagos realizados  => #{cuota.land_fee_payments.count} \n\n"
			puts "\n lo q se debe de esta cuota es => #{cuota.owes} \n"
			
			cuota.payment += self.total 

			if cuota.payment > cuota.total_value
				puts "\n ####################### pago mas de el valor de la cuota \n"
				cuota.owes = 0
				cuota.pago_supera_cuota
			else 
				cuota.owes = cuota.total_value - cuota.payment 
			end

			if cuota.total_value <= cuota.payment
				cuota.pay_status = :pagado
			end

			cuota.save!
		else 
			puts "\n Primer pago de la cuota \n" if cuota.land_fee_payments.count == 1
			puts "\n Pago de adelanto o de deuda \n" if self.total == 0.0
		end
	end
end
