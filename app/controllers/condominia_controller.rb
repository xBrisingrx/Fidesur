class CondominiaController < ApplicationController
  before_action :set_condominium, only: %i[ show edit update destroy ]

  # GET /condominia or /condominia.json
  def index
    @condominia = Condominium.where(active:true)
  end

  # GET /condominia/1 or /condominia/1.json
  def show
  end

  # GET /condominia/new
  def new
    @condominium = Condominium.new
  end

  # GET /condominia/1/edit
  def edit
  end

  # POST /condominia or /condominia.json
  def create
    @condominium = Condominium.new(condominium_params)

    respond_to do |format|
      if @condominium.save
        format.json { render json: { status: 'success', msg: 'Condominio registrado' }, status: :created }
      else
        format.json { render json: @condominium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /condominia/1 or /condominia/1.json
  def update
    respond_to do |format|
      if @condominium.update(condominium_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok }
      else
        format.json { render json: @condominium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /condominia/1 or /condominia/1.json
  def destroy
    @condominium.destroy

    respond_to do |format|
      format.html { redirect_to condominia_url, notice: "Condominium was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @condominium = Condominium.find(params[:condominium][:id])
    if @condominium.update(active:false)
      render json: { status: 'success', msg: 'Condominio eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_condominium
      @condominium = Condominium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def condominium_params
      params.require(:condominium).permit(:name, :description, :active)
    end
end
