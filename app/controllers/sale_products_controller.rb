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

    @fees = @sale.fees #obtengo cuotas
    @total_pagado = @sale.total_pagado
    # (@land_fees.sum(:payment) + @sale_product.sale.paid)

    # if @sale_product.sale.total_cost == 0.0
    #   @sale_product.sale.calculate_total_value!
    # end
    @product_value = @sale.total_cost
    @total_adeudado = @sale.total_cost - @total_pagado

    @cant_vencidas = @fees.where( "due_date < ?", Time.new ).where(payed: false).count
    @cuotas_pagadas =  @fees.where(payed: true).count
    @total_cuotas = @fees.count
    @status = { 'pendiente' => 'Pendiente', 'pagado' => 'Pagada', 'pago_parcial' => 'Pago parcial'}

    # puts "\n\n rollback"
    # venta_lote = FieldSale.find_by( field_id: 408 )
    # cuotas = venta_lote.sale.land_fees
    # cuotas.each do |cuota|
    #   cuota.land_fee_payments.destroy_all
    #   cuota.update(
    #     pay_date: nil,
    #     owes: cuota.fee_value,
    #     payment: 0,
    #     pay_status: :pendiente,
    #     payed: false,
    #     comment: ''
    #   )
    # end
    # puts "\n\n End rollback"

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

  private
    def set_sale_product
      @sale_product = SaleProduct.find(params[:id])
    end

    def sale_product_params
      params.require(:sale_product).permit(:sale_id, :product_id, :product_type, :comment, :active)
    end
end
