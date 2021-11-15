class FieldSaleController < ApplicationController

	def index
		# Estado de cuotas del lote
		@field_sale = FieldSale.where( field_id: params[:field_id] ).first
    @id = params[:field_id]
    @sale = Sale.find(@field_sale.sale_id)
    @batch_payments = @sale.batch_payments
    @cant_vencidas = @batch_payments.where( "due_date < ?", Time.new ).where(payed: false).count
    @cuotas_pagadas =  @batch_payments.where(payed: true).count
    @total_cuotas = @batch_payments.count
    @status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}
    respond_to do |format|
    	format.html
      format.json
    end
	end

end
