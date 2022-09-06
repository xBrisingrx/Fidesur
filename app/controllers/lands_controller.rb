class LandsController < ApplicationController
  before_action :set_land, only: %i[ edit update ]
  before_action :set_apple, only: %i[ index new create edit ]
  before_action :set_name_enums, only: %i[ index new edit ]

  def index
    @lands = Land.where(apple_id: params[:apple_id], active: true)
    @apple_id = params[:apple_id]
  end

  def new
    @title_modal = 'Nuevo lote'
  end

  def edit
    @title_modal = 'Editar lote'
    @blueprint = (@land.blueprint.attached?) ? 'Actualizar plano' : 'Adjuntar plano'
  end

  def create
    @apple = Apple.find(params[:apple_id])
    @land = @apple.lands.new(land_params)
    @user = User.find current_user.id
    @land.user_created = @user
    @land.user_updated = @user

    respond_to do |format|
      if @land.save
        format.json { render json: {status: 'success', msg: 'Lote registrado'} , status: :created }
      else
        format.json { render json: @land.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @land.update(land_params)
        format.json { render json: {status: 'success', msg: 'Lote actualizado'} , status: :ok }
      else
        format.json { render json: @land.errors, status: :unprocessable_entity }
      end
    end
  end

  def disable
    @land = Land.find(params[:land][:id])
    if @land.libre? || @land.cancelado?
      if @land.update(active:false)
        render json: { status: 'success', msg: 'Lote eliminado' }, status: :ok
      else
        render json: { status: 'error', msg: 'Ocurrio un error al realizar la operación' }, status: :unprocessable_entity
      end
    end

    rescue => e
        @response = e.message.split(':')
        render json: { @response[0] => @response[1] }, status: 402
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_land
      @land = Land.find(params[:id])
    end

    def set_apple
      @apple = Apple.find(params[:apple_id])
    end

    # Paso a :es mis enumarados
    def set_name_enums
      @status = { 'available' => 'Disponible', 'bought' => 'Comprado', 'canceled' => 'Cancelado'}
      @land_type = { 'habitable' => 'Habitable', 'no_habitable' => 'No habitable', 'green_space' => 'Espacio verde' }
    end

    # Only allow a list of trusted parameters through.
    def land_params
      params.require(:land).permit(:measures, :surface, :ubication, :price, :code, :status, :blueprint, :land_type, :is_green_space)
    end
end
