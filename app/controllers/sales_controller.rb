class SalesController < ApplicationController

  def start_field_sale
    # vendo un solo lote, aca me viene un lote por parametro ya seteado
    @clients = Client.where(active:true)
    @field = Field.find(params[:field_id])
    @title_modal = "Venta del lote #{@field.code}"
  end

  def create 
    if params[:clients].blank?
      return render json: {status: 'error', msg: 'No se han seleccionado clientes'}
    end
    ActiveRecord::Base.transaction do 
      sale = Sale.new(
        apply_arrear: params[:apply_arrear],
        arrear: params[:arrear],
        comment: params[:comment],
        due_date: params[:due_date],
        number_of_payments: params[:number_of_payments].to_i,
        paid: params[:paid],
        total_cost: 0
      )

      if sale.paid.nil?
        sale.paid = 0.0
      end

      if sale.save! 
        params[:clients].uniq # me aseguro de que no haya ningun id repetido
        params[:clients].each do |client|
          # Generamos los registros de los clientes que hicieron la compra
          sale.client_sales.create!(client_id: client)
        end
        if sale.field_sales.create!(field_id: params[:field_id])
          # Si la venta del lote se registro con exito
          field = Field.find(params[:field_id])
          field.update!(status: :bought)
        end

        # Fecha de compra
        if params[:fecha_compra]
          today = Date.parse(params[:fecha_compra])
        else
          today = Time.new
        end
        
        # Fecha de vencimiento si venciera ESTE mes, en base a eso saco las siguientes fechas de vencimiento
        due_date = Time.new(today.year, today.month, params[:due_date].to_i)

        # El costo total que va a pagar el cliente es lo que entrega mas el valor de la cuota
        # El valor de la cuota puede ser que cambie , el valor total incrementa
        valor_cuota = params[:valor_cuota]
        sale.total_cost = sale.paid + ( valor_cuota * sale.number_of_payments )

        # valor de cuota es el costo de mi lote - lo que el cliente pago dividido cantidad de cuotas pactadas
        # valor_cuota = (sale.total_cost - sale.paid) / sale.number_of_payments 

        if sale.apply_arrear
          valor_interes = (valor_cuota * sale.arrear) / 100
        else
          valor_interes = 0.0 
        end

        for i in 1..sale.number_of_payments
          due_date += 1.month
          cuota = BatchPayment.create!(due_date: due_date, money: valor_cuota, number: i, sale_id: sale.id, interest: valor_interes.round(2))
        end
        render json: {status: 'success', msg: 'Venta exitosa'}
      else
        render json: {status: 'errors', msg: 'No se pudo registrar la venta'}
      end #end if

    end # transaction

    rescue => e
      puts "Excepcion => #{e.message}"
      @response = e.message.split(':')
      render json: {status: 'errors', msg: 'No se pudo registrar la venta'}, status: 402
  end # create


  def show_field_sale
    @field_sale = FieldSale.find(params[:field_id])
    @id = params[:field_id]
    @sale = Sale.find(@field_sale.sale_id)
    @batch_payments = @sale.batch_payments
    @cant_vencidas = @batch_payments.where( "due_date < ?", Time.new ).count
  end

  def pay
    puts "esto es una B => #{params}"
    puts "filtrado #{params[:data]}"
    cuota = BatchPayment.find(params[:data])

    render json: { 'data' => cuota, 'interest' => cuota.sale.arrear }
  end

  def lotes_cliente
    # Vista q muestra los lotes q compr 1 cliente
    @sale = ClientSale.where(client_id: params[:client_id])
    puts @sale.count
  end



  private
  # def field_params
  #    params.require(:field).permit(:measures, :surface, :ubication, :price, :code, :status, :is_green_space, :space_not_available, :blueprint)
  #  end

end
