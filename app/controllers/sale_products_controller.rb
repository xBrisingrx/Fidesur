class SaleProductsController < ApplicationController
  before_action :set_sale_product, only: %i[ edit update destroy ]

  def index
    @sale_products = SaleProduct.all
  end

  def show
    # Estado de cuotas de la venta
    @sale_product = SaleProduct.find_by( product_id: params[:product_id], product_type: params[:product_type] )

    @id = params[:product_id]
    @sale = Sale.find(@sale_product.sale_id)
    @sale.corregir_fecha_primer_pago
    @fees = @sale.fees.where('number != 0') #obtengo cuotas descartando el pago inicial
    @total_pagado = @sale.total_pagado

    @product_value = @sale.total_cost
    @total_adeudado = @sale.total_cost - @total_pagado

    @cant_vencidas = @fees.where( "due_date < ?", Time.new ).where(payed: false).count
    @cuotas_pagadas =  @fees.where(payed: true).count
    @total_cuotas = @fees.count
    @status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @sale_product = SaleProduct.new
  end

  def edit
  end

  def create
    @sale_product = SaleProduct.new(sale_product_params)

    respond_to do |format|
      if @sale_product.save
        format.html { redirect_to sale_product_url(@sale_product), notice: "Sale product was successfully created." }
        format.json { render :show, status: :created, location: @sale_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @sale_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale_product.update(sale_product_params)
        format.html { redirect_to sale_product_url(@sale_product), notice: "Sale product was successfully updated." }
        format.json { render :show, status: :ok, location: @sale_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale_product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale_product.destroy

    respond_to do |format|
      format.html { redirect_to sale_products_url, notice: "Sale product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def all_lands
    @lands = SaleProduct.where( active: true, product_type: 'Land' )
  end

  def get_totales_cuota
    product = SaleProduct.find_by( product_id: params[:product_id], product_type: params[:product_type] )
    cuotas = product.sale.fees.where('number > 0')
    total_pagado = ( cuotas.sum(:payment) )
    total_adeudado = product.product.price - total_pagado
    cuotas_pagadas = cuotas.where(payed:true).count
    cant_cuotas = cuotas.count

    render json: {'debe' => cuotas.sum(:owes), 
                  'haber' => cuotas.sum(:payment), 
                  'total_pagado' => total_pagado, 
                  'total_adeudado' => total_adeudado,
                  'cuotas_pagadas' => cuotas_pagadas,
                  'cant_cuotas' => cant_cuotas}
  end

  def modal_apply_adjust
    @title_modal = "Aplicar ajuste"
    @sale = Sale.find params[:sale_id]
    @fees = @sale.fees.actives.no_cero.no_payed
  end

  def apply_adjust
    sale = Sale.find params[:sale_id]
    fee = Fee.where(sale_id: sale.id, number: params[:fee_number]).first
    ActiveRecord::Base.transaction do 
      if params[:apply_to_one_fee].to_i == 1
        fee.apply_adjust_one_fee params[:adjust].to_f
      else
        fee.apply_adjust_include_fee params[:adjust].to_f
      end
      sale.calculate_total_value!
      render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok
    end
    rescue => e
      puts "Excepcion => #{e.message}"
      @response = e.message.split(':')
      render json: {status: 'error', msg: 'No se pudo registrar el ajuste'}, status: 402
  end

  private
    def set_sale_product
      @sale_product = SaleProduct.find(params[:id])
    end

    def sale_product_params
      params.require(:sale_product).permit(:sale_id, :product_id, :product_type, :comment, :active)
    end
end
