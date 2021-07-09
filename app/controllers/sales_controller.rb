class SalesController < ApplicationController

  def start_field_sale
    # vendo un solo lote, aca me viene un lote por parametro ya seteado
    @clients = Client.where(active:true)
    @field = Field.find(params[:field_id])
    @title_modal = "Venta del lote #{@field.code}"
  end

  def create 
    params[:clients].select {  }
    ActiveRecord::Base.transaction do 

      sale = Sale.new(
        apply_arrear: params[:apply_arrear],
        arrear: params[:arrear],
        comment: params[:comment],
        due_date: params[:due_date],
        number_of_payments: params[:number_of_payments],
        paid: params[:paid],
        total_cost: params[:total_cost]
      )
      if sale.save! 
        params[:clients].uniq # me aseguro de que no haya ningun id repetido
        params[:clients].each do |client|
          # Generamos los registros de los clientes que hicieron la compra
          @client_sale = sale.client_sales.create!(client_id: client)
        end
        if @field_sale = sale.field_sales.create!(field_id: params[:field_id])
          # Si la venta del lote se registro con exito
          field = Field.find(params[:field_id])
          field.update!(status: :bought)
        end

        render json: {status: 'success', msg: 'Venta exitosa'}
      else
        puts 'no se guardo'
      end #end if
    
      # rescue ActiveRecord::Rollback e =>
        # puts "Oops. We tried to do an invalid operation!"

    end # transaction

    rescue => e
      @response = e.message.split(':')
      puts @response
      render json: { @response[0] => @response[1] }, status: 402

   end # create


   def show_field_sale
    @field_sale = FieldSale.find(params[:field_id])
    sale = Sale.find(@field_sale.sale_id)
   end

   private
   # def field_params
   #    params.require(:field).permit(:measures, :surface, :ubication, :price, :code, :status, :is_green_space, :space_not_available, :blueprint)
   #  end

end
