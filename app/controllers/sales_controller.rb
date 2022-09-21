class SalesController < ApplicationController
  def index;end
  
  def new 
    @clients = Client.select(:id, :name, :last_name).where(active: true)
    @product = [ 'product_id' => params[:product_id], 'product_type' => params[:product_type] ]
    @currencies = Currency.select(:id, :name).where(active: true)
    @sale = Sale.new
    @product_type = params[:product_type]
    @product_id = params[:product_id]
    
    case @product_type
      when 'land'
         @product = Land.select(:id, :price, :code).find(@product_id) 
         @title_modal = "Venta del lote #{@product.code}"
      else 
        raise "No es un producto reconocido"
    end
  end
  
  def start_field_sale
    # vendo un solo lote, aca me viene un lote por parametro ya seteado
    @clients = Client.select(:id, :name, :last_name).where(active: true)
    @field = Field.find(params[:field_id])
    @title_modal = "Venta del lote #{@field.code}"
    @currencies = Currency.select(:id, :name).where(active: true)
    @sale = Sale.new
  end

  def create 
    if params[:clients].blank?
      return render json: {status: 'error', msg: 'No se han seleccionado clientes'}, status: 422
    end
    ActiveRecord::Base.transaction do 
      sale = Sale.new(
        apply_arrear: params[:apply_arrear],
        arrear: params[:arrear],
        comment: params[:comment],
        sale_date: params[:sale_date],
        due_date: params[:due_date],
        number_of_payments: params[:number_of_payments],
        total_cost: 0 )
      if sale.save! 
        params[:clients].uniq # me aseguro de que no haya ningun id repetido
        params[:clients].each do |client| # Generamos los registros de los clientes que hicieron la compra
          sale.client_sales.create!(client_id: client)
        end

        sale.sale_products.create!(product_type: params[:product_type].capitalize,product_id: params[:product_id]) # reg venta del producto
        
        if params[:num_pays].to_i > 0 # Se ingreso un primer pago
          cuota_cero = sale.fees.create(
            due_date: sale.sale_date,
            pay_date: sale.sale_date,
            value: 1,
            number:0, 
            payed: true,
            pay_status: :pagado,
            comment: "Primer entrega")

          for i in 1..params[:num_pays].to_i do 
            currency_id = params["currency_id_#{i}".to_sym].to_i
            value_in_pesos = params["value_in_pesos_#{i}".to_sym].to_f
            paid = params["payment_#{i}".to_sym].to_f
            fee_payment = cuota_cero.fee_payments.new(
              currency_id: currency_id,
              payment: paid,
              total: ( ( currency_id == 2) || ( currency_id == 3) ) ? value_in_pesos : paid,
              tomado_en: params["tomado_en_#{i}".to_sym].to_f,
              pay_name: params["detail_#{i}".to_sym]
            )
            if !params["files_#{i}".to_sym].blank?
              fee_payment.images = params["files_#{i}".to_sym]
            end
            fee_payment.save!
          end
          cuota_cero.calcular_primer_pago
        end

        sale.calculate_total_paid!
        # Fecha de compra
        today = sale.sale_date 

        # Fecha de vencimiento si venciera ESTE mes, en base a eso saco las siguientes fechas de vencimiento
        due_date = Time.new(today.year, today.month, sale.due_date.to_i)
        if params[:setear_cuotas_manual] == "true"
           sale.generar_cuotas_manual( params[:valores_cuota] )
        else
          sale.generar_cuotas( params[:number_cuota_increase].to_i, params[:valor_cuota_aumentada].to_f, params[:valor_cuota].to_f )
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
    cuota = LandFee.find(params[:data])
    render json: { 'data' => cuota, 'interest' => cuota.sale.arrear }
  end

  def lotes_cliente
    # Vista q muestra los lotes q compr 1 cliente
    @sale = ClientSale.where(client_id: params[:client_id])
    puts @sale.count
  end

  private

  def sale_params
    params.require(:sale).permit(:total_cost, :apply_arrear, :arrear, :number_of_payments, 
      :due_date, :sale_date, :comment,
      client_sales_attributes: [:client_id],
      sale_products_attributes: [:product_type,:product_id])
  end

end
