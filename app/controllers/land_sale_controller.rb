class LandSaleController < ApplicationController
  def index
  end

  def new
    @clients = Client.select(:id, :name, :last_name).where(active: true)
    @product = Field.select(:id, :code, :price).find(params[:field_id])
    @land_sale = LandSale.new(product: @product)
    @currencies = Currency.select(:id, :name).where(active: true)
    puts " *** #{@land_sale}"
    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
  end
end
