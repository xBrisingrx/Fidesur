# == Schema Information
#
# Table name: fee_payments
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  comment     :text(65535)      default("''")
#  pay_date    :date
#  pay_name    :string(255)      default("")
#  payment     :decimal(15, 2)   default(0.0)
#  tomado_en   :decimal(15, 2)   default(1.0)
#  total       :decimal(15, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  currency_id :bigint
#  fee_id      :bigint
#
# Indexes
#
#  index_fee_payments_on_currency_id  (currency_id)
#  index_fee_payments_on_fee_id       (fee_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (fee_id => fees.id)
#
class FeePayment < ApplicationRecord
  belongs_to :fee
  belongs_to :currency
  has_many_attached :images
  
  after_create :update_fee 

  def update_fee
    # actualizamos el monto pagado
    cuota = self.fee
    # Si el total pagado es 0.0 significa que son las cuotas que genero de adelanto o pago de deuda
    if cuota.fee_payments.count > 1 && self.total != 0.0
      puts "\n\n pagos realizados  => #{cuota.fee_payments.count} \n\n"
      puts "\n lo q se debe de esta cuota es => #{cuota.owes} \n"
      
      cuota.payment += self.total 

      if cuota.owes < self.total 
        puts "\n ####################### el valor abonado es mayor al q se debe de la cuota \n"
        payment = self.total - cuota.owes # excedente
        cuota.owes = 0
        cuota.pago_supera_cuota( payment, self.pay_date )
      else 
        cuota.owes = cuota.total_value - cuota.payment 
      end

      if cuota.total_value <= cuota.payment
        cuota.pay_status = :pagado
      end

      cuota.save!
    else 
      puts "\n Primer pago de la cuota \n" if cuota.fee_payments.count == 1
      puts "\n Pago de adelanto o de deuda \n" if self.total == 0.0
    end
  end

end
