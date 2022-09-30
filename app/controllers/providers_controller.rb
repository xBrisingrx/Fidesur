class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[ show edit update destroy ]

  # GET /providers or /providers.json
  def index
    @providers = Provider.where(active:true)
  end

  # GET /providers/1 or /providers/1.json
  def show
  end

  # GET /providers/new
  def new
    @title_modal = "Agregar proveedor"
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers or /providers.json
  def create
    @provider = Provider.new(provider_params)
    @user = User.find current_user.id
    @provider.user_created = @user
    @provider.user_updated = @user

    respond_to do |format|
      if @provider.save
        format.json { render json: { status: 'success', msg: 'Proveedor registrado' }, status: :created }
      else
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1 or /providers/1.json
  def update
    @user = User.find current_user.id
    @provider.user_updated = @user
    respond_to do |format|
      if @provider.update(provider_params)
        format.json { render json: { status: 'success', msg: 'Datos actualizados' }, status: :ok }
      else
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1 or /providers/1.json
  def destroy
    @provider.destroy

    respond_to do |format|
      format.html { redirect_to providers_url, notice: "Provider was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @provider = Provider.find(params[:provider][:id])
    if @provider.update(active:false)
      render json: { status: 'success', msg: 'Proveedor eliminado' }, status: :ok
    else
      render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
    end

    rescue => e
      @response = e.message.split(':')
      render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = Provider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def provider_params
      params.require(:provider).permit(:name, :cuit, :description, :activity, :active, :user_id)
    end
end
