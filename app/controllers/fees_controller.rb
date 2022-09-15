class FeesController < ApplicationController
	
	def index
		# Obtengo las cuotas de una venta
		@fees = Fee.where(sale_id: params[:sale_id]).where('number != 0')
		@status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}
	end

	def show
		@currencies = Currency.select(:id, :name).where(active: true)
    # obtengo info de una sola cuota
    @fee = Fee.find(params[:id])
    @title_modal = "Pagar cuota ##{@fee.number}"
    # Plata que quedo pendiente de cuotas anteriores 
    @adeuda = @fee.get_deuda
    # testeo que este vencida la cuota y que se haya seteado q se corresponda aplicar intereses
    if @fee.apply_arrear?
      # El % que se seteo cuando se hizo la venta
      @porcentaje_interes = @fee.sale.arrear
      # Esto es el valor calculado del interes diario
      # @interes_sugerido = calcular_interes!(@porcentaje_interes, @fee.fee_value, @fee.due_date)
      @interes_sugerido = 0
      @total_a_pagar = @fee.value + @interes_sugerido + @adeuda
    else 
      @porcentaje_interes = 0
      @interes = 0.0
      @total_a_pagar = @fee.value + @adeuda
    end
	end
end
