class SaleProductsController < ApplicationController
  before_action :set_sale_product, only: %i[ show edit update destroy ]

  def index
    @sale_products = SaleProduct.all
  end

  def show
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
