class FieldSaleController < ApplicationController

	def index
		# Estado de cuotas del lote
		@field_sale = FieldSale.find_by( field_id: params[:field_id] )

    @id = params[:field_id]
    @sale = Sale.find(@field_sale.sale_id)
    @land_fees = @sale.land_fees #obtengo cuotas
    @total_pagado = (@land_fees.sum(:payment) + @field_sale.sale.paid)

    if @field_sale.sale.total_cost == 0.0
      @field_sale.sale.calculate_total_value!
    end
    @valor_lote = @field_sale.sale.total_cost
    @total_adeudado = @field_sale.sale.total_cost - @total_pagado

    @cant_vencidas = @land_fees.where( "due_date < ?", Time.new ).where(payed: false).count
    @cuotas_pagadas =  @land_fees.where(payed: true).count
    @total_cuotas = @land_fees.count
    @status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}
    respond_to do |format|
    	format.html
      format.json
    end
	end

  def get_totales_cuota
    lote_vendido = FieldSale.find_by( field_id: params[:field_id] )
    cuotas = lote_vendido.sale.land_fees
    total_pagado = (cuotas.sum(:payment) + lote_vendido.sale.paid)
    total_adeudado = lote_vendido.field.price - total_pagado
    cuotas_pagadas = cuotas.where(payed:true).count
    cant_cuotas = cuotas.count

    render json: {'debe' => cuotas.sum(:owes), 
                  'haber' => cuotas.sum(:payment), 
                  'total_pagado' => total_pagado, 
                  'total_adeudado' => total_adeudado,
                  'cuotas_pagadas' => cuotas_pagadas,
                  'cant_cuotas' => cant_cuotas}
  end

  def all_fields # show all field
    @fields = FieldSale.where( active: true )
  end
end
