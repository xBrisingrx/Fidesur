# == Schema Information
#
# Table name: fees
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE)
#  adjust         :decimal(15, 2)   default(0.0)
#  comment        :text(65535)      default("''")
#  comment_adjust :text(65535)      default("''")
#  due_date       :date
#  interest       :decimal(15, 2)   default(0.0)
#  number         :integer          not null
#  owes           :decimal(15, 2)   default(0.0)
#  pay_date       :date
#  pay_status     :integer          default("pendiente")
#  payed          :boolean          default(FALSE)
#  payment        :decimal(15, 2)   default(0.0)
#  total_value    :decimal(15, 2)   default(0.0)
#  value          :decimal(15, 2)   default(0.0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  sale_id        :bigint
#
# Indexes
#
#  index_fees_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (sale_id => sales.id)
#
class Fee < ApplicationRecord 
  # modelo de cuotas
  # value es el valor de la cuota cuando se creo
  # total_value es el valor de la cuota sumando ajuste y mora. Este es el valor que se debe pagar de forma total
  # number es el numero de cuota
  # payment es lo que se pago 
  # owes es lo que se adeuda de la cuota, nos ayuda para saber si la cuota se pago entera o de forma parcial
  belongs_to :sale
  has_many :fee_payments, dependent: :destroy

  enum pay_status: [:pendiente, :pagado, :pago_parcial]
  
  def expired?
    self.due_date.strftime("%F")  < Time.new.strftime("%F") 
  end

  def apply_arrear?
    self.expired? && self.sale.apply_arrear
  end

  def get_deuda
    Fee.where(sale_id: self.sale_id).where('number < ?', self.number).where( 'due_date < ?', Time.new.strftime("%F") ).where('owes > 0').sum('owes')
  end

  def has_debt?
    self.get_deuda > 0
  end

  def calcular_primer_pago
    primer_pago = self.fee_payments.sum(:total)
    self.update( payment: primer_pago , value: primer_pago ,total_value: primer_pago )
  end
  
  def aply_adjust adjust
    puts "\n\n\n\n\n ****************5 Aplicamos el ajuste a partir de la cuota #{self.number} \n"
    cuotas = Fee.where(["sale_id = ? and number > ?", self.sale_id, self.number ])
    cuotas.each do |cuota|
      "\n Ajustamos en la cuota #{cuota.number} q tenia de ajuste #{cuota.adjust.to_f} \n"
      cuota.adjust += adjust
      cuota.total_value = cuota.value + cuota.interest + cuota.adjust
      cuota.owes += cuota.adjust
      cuota.save
      "\n Update exitoso #{cuota.adjust.to_f}"
    end
  end

  def pago_supera_cuota payment, pay_date
    puts "\n ######### EXTRA #{payment.to_f} ######### \n"
    puts "\n ========================  Pago de otras cuotas ============================= \n"
    # Obtengo todas las cuotas que no estan pagadas distintas a la que se esta pagando en este momento
    cuotas_a_pagar = Fee.where(sale_id: self.sale_id).where('number != ?', self.number).where('owes > 0').order('id ASC')
    puts "\n *** Cantidad de cuotas encontradas #{ cuotas_a_pagar.count } \n"
    cuotas_a_pagar.each do |cuota| 
      puts "\n Payment menor a cero => #{payment.to_f} \n" if payment <= 0.0
      return if payment <= 0.0
      puts "De la cuota #{ cuota.number } debe #{ cuota.owes.to_f }"
      # pago a registrar, se deja en cero el monto porque es para lleva el registro de adelantos/pago deuda
      pago = cuota.fee_payments.new(
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

  def reset_payments
    self.fee_payments.destroy_all
    self.update(
      owes: self.value,
      total_value: self.value,
      comment: '',
      comment_adjust:'',
      adjust: 0,
      pay_status: :pendiente,
      payment: 0,
      payed: 0,
      interest: 0
    )
  end
end
# debe C1 = $40.612,50