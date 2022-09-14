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
#  pay_status     :integer          default(0)
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
  belongs_to :sale
  has_many :fee_payments

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

  def calcular_primer_pago
    self.update( payment: self.fee_payments.sum(:total) )
  end
  
end
