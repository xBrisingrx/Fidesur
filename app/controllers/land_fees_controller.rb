class LandFeesController < ApplicationController
  before_action :set_land_fee, only: %i[ show edit update destroy ]

  # Este controlador maneja el pago de cuotas
  def index
    # obtengo el detalle de cuotas de un lote
    @field_sale = FieldSale.find(params[:field_id])
    @id = params[:field_id]
    @sale = Sale.find(@field_sale.sale_id)
    @land_fees = @sale.land_fees
    @cant_vencidas = @land_fees.where( "due_date < ?", Time.new ).where(payed: false).count
  end

  def show
    @currencies = Currency.select(:id, :name).where(active: true)
    # obtengo info de una sola cuota
    @land_fee = LandFee.find(params[:id])
    @title_modal = "Pagar cuota ##{@land_fee.number}"
    # Plata que quedo pendiente de cuotas anteriores 
    @adeuda = @land_fee.get_deuda
    # testeo que este vencida la cuota y que se haya seteado q se corresponda aplicar intereses
    if @land_fee.apply_arrear?
      # El % que se seteo cuando se hizo la venta
      @porcentaje_interes = @land_fee.sale.arrear
      # Esto es el valor calculado del interes diario
      @interes_sugerido = calcular_interes!(@porcentaje_interes, @land_fee.fee_value, @land_fee.due_date)

      @total_a_pagar = @land_fee.fee_value + @interes_sugerido + @adeuda
    else 
      @porcentaje_interes = 0
      @interes = 0.0
      @total_a_pagar = @land_fee.fee_value + @adeuda
    end
  end

  def update # Actualizar los valores de una cuota sigifica que se pago esa cuota
    cuota = LandFee.find(params[:id])
    ActiveRecord::Base.transaction do 
      # payment es lo que se pago, ese valor viene en calculo_en_pesos
      cuota.payment = params[:calculo_en_pesos].to_f

      # chequeamos si se le sumo intereses
      if params[:interest].to_f > 0
        # discrimino el interes aplicado en la cuota
        cuota.interest = params[:interest].to_f
      end

      # Si agregaron algo al ajuste sumamos 
      if params[:adjust].to_f > 0 
        cuota.adjust += params[:adjust].to_f
        cuota.aply_adjust(params[:adjust].to_f)
      end
      
      cuota.comment_adjust = params[:comment_adjust]

      # Calculo el total que se deberia haber pagado
      # Aca no sumo el valor de cuotas anteriores
      cuota.total_value = cuota.fee_value + cuota.interest + cuota.adjust 

      # Chequeo si se pago menos de lo que se debia, en caso de que haya sido asi pasa al atributo DEBE
      if ( cuota.total_value >= cuota.payment )
        cuota.owes = (cuota.total_value - cuota.payment).round(2)
      else
        cuota.owes = 0.0
      end
      cuota.pay_date = params[:pay_date]
      cuota.payed = true
      cuota.comment = params[:comment]

      # si debe plata el status es pago parcial , sino pago total
      cuota.pay_status = ( cuota.owes > 0 ) ? :pago_parcial : :pagado
      # si el valor de la cuota cambia tenemos que actualizar el valor de la venta del lote
      recalcular_valor_venta = cuota.total_value_changed?
      if cuota.save!
        cuota.sale.calculate_total_value! if recalcular_valor_venta
        # este es el pago de la primer cuota 
        pago_de_cuota = cuota.land_fee_payments.new( 
            pay_date: cuota.pay_date, 
            payment: params[:payment], 
            tomado_en: params[:value_in_pesos],
            total: params[:calculo_en_pesos],
            pay_name: params[:name_pay],
            currency_id: params[:currency_id],
            comment: params[:comment] )
        if !params[:images].nil?
          pago_de_cuota.images = params[:images]
        end

        if pago_de_cuota.save!
          # Lo abonado es mayor a lo que se debe de la cuota
          cuota.pago_supera_cuota( cuota.payment - cuota.total_value, cuota.pay_date ) if ( cuota.total_value < cuota.payment )
          render json: { status: 'success', msg: 'Pago registrado' }, status: 200
        else
          render json: { status: 'error', msg: 'No se pudo registrar el pago' }, status: 422
        end
      else
        render json: { status: 'error', msg: 'No se pudo registrar el pago' }, status: 422
      end
      # raise 'lands fees/update'
    end # end transaction
    rescue => e
      @response = e.message.split(':')
      puts @response
      render json: { status: 'error', msg: 'No se pudo registrar el pago' }, status: 402
  end

  def detalle_pago_cuota
    @cuota = LandFee.find(params[:id])
    @title_modal = 'Detalle del pago realizado'
  end

  def calcular_interes! porcentaje_interes, valor_cuota, fecha_vencimiento
    # Calculo el interes diario
    # Se resta el dia de hoy con la fecha de vencimiento de la cuota
    hoy = Date.today
    interes_diario = (valor_cuota * porcentaje_interes) / 100
    interes = interes_diario * ( hoy - fecha_vencimiento ).to_i
    interes.round(2)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_land_fee
    @land_fee = LandFee.find(params[:id])

  end

  # Only allow a list of trusted parameters through.
  def land_fee_params
    params.require(:land_fee).permit(:due_date, :interest, :fee_value, :number, :owes,:pay_date, :pay_status, 
                      :payed, :payment, :total_value, :comment, :comment_adjust, :aply_arrear,
                      :value_in_pesos, :pay_name, :images[], :currency_id, :calculo_en_pesos)
  end

end
