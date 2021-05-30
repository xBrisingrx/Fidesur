class ApplesController < ApplicationController
  before_action :set_apple, only: %i[ show edit update destroy ]

  # GET /apples or /apples.json
  def index
    @apples = Apple.where( active: true )
  end

  # GET /apples/1 or /apples/1.json
  def show
  end

  # GET /apples/new
  def new
    @title_modal = "Agregar manzana"
    @sectors = Sector.where(active: :true)
    @apple = Apple.new
  end

  # GET /apples/1/edit
  def edit
    @title_modal = "Editar manzana"
    @sectors = Sector.where(active: :true)
  end

  # POST /apples or /apples.json
  def create
    @apple = Apple.new(apple_params)

    respond_to do |format|
      if @apple.save
        format.json { render json: { status: 'success', msg: 'Manzana registrada' }, status: :created }
      else
        format.json { render json: @apple.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apples/1 or /apples/1.json
  def update
    respond_to do |format|
      if @apple.update(apple_params)
        # format.html { redirect_to @apple, notice: "Apple was successfully updated." }
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok, location: @apple }
      else
        # format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @apple.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apples/1 or /apples/1.json
  def destroy
    @apple.destroy
    respond_to do |format|
      format.html { redirect_to apples_url, notice: "Apple was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @apple = Apple.find(params[:apple][:id])
    if @apple.update!(active: false)
      render json: { status: 'success', msg: 'Manzana eliminada' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apple
      @apple = Apple.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def apple_params
      params.require(:apple).permit(:hectares, :location, :value, :code, :sector_id)
    end
end
