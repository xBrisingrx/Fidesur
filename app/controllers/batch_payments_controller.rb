class BatchPaymentsController < ApplicationController

	# Este controlador maneja el pago de cuotas
	def index
		# obtengo el detalle de cuotas de un lote
		@field_sale = FieldSale.find(params[:field_id])
    @id = params[:field_id]
    @sale = Sale.find(@field_sale.sale_id)
    @batch_payments = @sale.batch_payments
    @cant_vencidas = @batch_payments.where( "due_date < ?", Time.new ).where(payed: false).count
	end

	def show
		@title_modal = 'Pagar cuota'
		# obtengo info de una sola cuota
		@batch_payment = BatchPayment.find(params[:id])

		# Check si adeuda plata de una cuota anterior
		cuota_anterior = BatchPayment.where(sale_id: @batch_payment.sale_id, number: @batch_payment.number - 1).first
		if !cuota_anterior.nil?
			@adeuda = cuota_anterior.owes
		else
			@adeuda = 0.0
		end

		# testeo que este vencida la cuota y que se haya seteado q se corresponda aplicar intereses
		if @batch_payment.apply_arrear?
			# El % que se seteo cuando se hizo la venta
			@porcentaje_interes = @batch_payment.sale.arrear
			# Esto es el valor calculado del interes diario
			@interes_sugerido = calcular_interes!(@porcentaje_interes, @batch_payment.money, @batch_payment.sale.due_date)
			@interes = @batch_payment.interest
			@total_a_pagar = @batch_payment.money + @interes + @adeuda
		else 
			@porcentaje_interes = 0
			@interes = 0.0
			@total_a_pagar = @batch_payment.money + @adeuda
		end
	end

	def update # Actualizar los valores de una cuota sigifica que se pago esa cuota
		@cuota = BatchPayment.find(params[:id])
		if @cuota.apply_arrear?
			# discrimino el interes aplicado en la cuota
			@cuota.interest = params[:batch_payment][:interest].to_f
			# chequeo si hubo pago parcial y actualizo campo debe
			@cuota.owes = ( @cuota.money + @cuota.interest ) -  params[:batch_payment][:payment].to_f

		else
			# boraamos el monto si no se pago interes
			@cuota.interest = 0.0
			@cuota.owes = @cuota.money -  params[:batch_payment][:payment].to_f
		end

		if @cuota.owes < 0
			@cuota.owes = 0.0
		end

		@cuota.pay_date = Time.now
		@cuota.payed = true
		@cuota.payment = params[:batch_payment][:payment]
		@cuota.comment = params[:batch_payment][:comment]
		# si debe plata el status es pago parcial , sino pago total
		@cuota.pay_status = ( @cuota.owes > 0 ) ? :pago_parcial : :pagado

		if @cuota.save!
			render json: { status: 'success', msg: 'Pago registrado' }, status: 200
		else
			render json: { status: 'error', msg: 'No se pudo registrar el pago' }, status: 422
		end
		
		rescue => e
      @response = e.message.split(':')
      puts @response
      render json: { status: 'error', msg: 'No se pudo registrar el pago' }, status: 402
	end

	def detalle_pago_cuota
		@cuota = BatchPayment.find(params[:id])
		@title_modal = 'Detalle del pago realizado'
	end

	def calcular_interes! porcentaje_interes, valor_cuota, dia_vencimiento
		# Calculo el interes diario
		hoy = Time.now.day.to_i
		interes_diario = (valor_cuota * porcentaje_interes) / 100
		interes = interes_diario * ( hoy - dia_vencimiento + 5)
		interes
	end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_batch_payment
    @batch_payment = BatchPayment.find(params[:id])

  end

  # Only allow a list of trusted parameters through.
  def batch_payment_params
    params.require(:batch_payment).permit(:due_date, :interest, :money, :number, :owes,:pay_date, :pay_status, :payed, :payment, :total, :comment )
  end

end
