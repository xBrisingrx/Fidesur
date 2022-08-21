class SalesController < ApplicationController

  def start_field_sale
    # vendo un solo lote, aca me viene un lote por parametro ya seteado
    @clients = Client.where(active:true)
    @field = Field.find(params[:field_id])
    @title_modal = "Venta del lote #{@field.code}"
    @currencies = Currency.select(:id, :name).where(active: true)
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
        sale_date: (!params[:sale_date].blank?) ? params[:sale_date] : Time.now.strftime("%Y/%m/%d"),
        due_date: ( !params[:due_date].blank? ) ? params[:due_date] : 10,
        number_of_payments: params[:number_of_payments].to_i,
        total_cost: 0
      )

      if sale.save! 
        params[:clients].uniq # me aseguro de que no haya ningun id repetido
        params[:clients].each do |client| # Generamos los registros de los clientes que hicieron la compra
          sale.client_sales.create!(client_id: client)
        end
        if sale.field_sales.create!(field_id: params[:field_id]) # Si la venta del lote se registro con exito
          field = Field.find(params[:field_id])
          field.update!(status: :bought)
        end
        # Registramos los pagos
        all_payments = params[:num_pays].to_i
        for i in 1..all_payments do 
          currency_id = params["currency_id_#{i}".to_sym].to_i
          value_in_pesos = params["value_in_pesos_#{i}".to_sym].to_f
          paid = params["payment_#{i}".to_sym].to_f
          sales_payments = sale.sales_payments.new(
            currency_id: currency_id,
            value: paid,
            value_in_pesos: ( ( currency_id == 2) || ( currency_id == 3) ) ? value_in_pesos : paid,
            tomado_en: params["tomado_en_#{i}".to_sym].to_f,
            detail: params["name_pay_#{i}".to_sym]
          )
          if !params["files_#{i}".to_sym].blank?
            sales_payments.images = params["files_#{i}".to_sym]
          end
          sales_payments.save!
        end
        sale.calculate_total_paid!
        # Fecha de compra
        if !params[:sale_date].blank?
          today = Date.parse(params[:sale_date])
        else
          today = Time.new
        end

        # Fecha de vencimiento si venciera ESTE mes, en base a eso saco las siguientes fechas de vencimiento
        due_date = Time.new(today.year, today.month, sale.due_date.to_i)
        # El costo total que va a pagar el cliente es lo que entrega mas el valor de la cuota
        # El valor de la cuota puede ser que cambie , el valor total incrementa
        valor_cuota = params[:valor_cuota].to_f
        aumenta_cuota = ( params['number_cuota_increase'].to_i > 0 ) && ( params['valor_cuota_aumentada'].to_f > 0 )
        for i in 1..sale.number_of_payments
          # genero mis cuotas
          due_date += 1.month
          if aumenta_cuota && i >= params['number_cuota_increase'].to_i
            LandFee.create!(due_date: due_date, fee_value: params['valor_cuota_aumentada'].to_f, number: i, sale_id: sale.id, owes: params['valor_cuota_aumentada'].to_f)
          else
            # cuotas normales
            LandFee.create!(due_date: due_date, fee_value: valor_cuota, number: i, sale_id: sale.id, owes: valor_cuota)
          end
        end
        sale.calculate_total_value!
        
        render json: {status: 'success', msg: 'Venta exitosa'}, status: :ok
      else
        render json: {status: 'errors', msg: 'No se pudo registrar la venta'}, status: :unprocessable_entity
      end #end if
    end # transaction
    rescue => e
      puts "Excepcion => #{e.message}"
      @response = e.message.split(':')
      render json: {status: 'error', msg: 'No se pudo registrar la venta'}, status: 402
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
    cuota = LandFee.find(params[:data])

    render json: { 'data' => cuota, 'interest' => cuota.sale.arrear }
  end

  def lotes_cliente
    # Vista q muestra los lotes q compr 1 cliente
    @sale = ClientSale.where(client_id: params[:client_id])
    puts @sale.count
  end

  private

  # def sale_params
  #    params.require(:sale).permit(:params)
  #  end

end
