class FieldsController < ApplicationController
  before_action :set_field, only: %i[ show edit update destroy ]
  before_action :set_apple, only: %i[ index new create edit ]
  before_action :set_name_enums, only: %i[ index new edit ]

  # GET /fields or /fields.json
  def index
    @fields = Field.where(apple_id: params[:apple_id],active: true)
    @apple_id = params[:apple_id]
  end

  # GET /fields/1 or /fields/1.json
  def show
  end

  # GET /fields/new
  def new
    @title_modal = 'Nuevo lote'
  end

  # GET /fields/1/edit
  def edit
    @title_modal = 'Editar lote'
    @blueprint = (@field.blueprint.attached?) ? 'Actualizar plano' : 'Adjuntar plano'
  end

  # POST /fields or /fields.json
  def create
    @apple = Apple.find(params[:apple_id])
    @field = @apple.fields.create(field_params)
    respond_to do |format|
      if @field.save
        format.json { render json: {status: 'success', msg: 'Lote registrado'} , status: :created }
      else
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fields/1 or /fields/1.json
  def update
    respond_to do |format|
      if @field.update(field_params)
        format.json { render json: {status: 'success', msg: 'Lote actualizado'} , status: :ok }
      else
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fields/1 or /fields/1.json
  def destroy
    @field.destroy
    respond_to do |format|
      format.html { redirect_to fields_url, notice: "Field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def disable
    @field = Field.find(params[:field][:id])
    if @field.libre? || @field.cancelado?
      if @field.update(active:false)
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
    def set_field
      @field = Field.find(params[:id])
    end

    def set_apple
      @apple = Apple.find(params[:apple_id])
    end

    # Paso a :es mis enumarados
    def set_name_enums
      @status = { 'free' => 'Libre', 'bought' => 'Comprado', 'canceled' => 'Cancelado'}
      @field_type = { 'habitable' => 'Habitable', 'no_habitable' => 'No habitable', 'green_space' => 'Espacio verde' }
    end

    # Only allow a list of trusted parameters through.
    def field_params
      params.require(:field).permit(:measures, :surface, :ubication, :price, :code, :status, :is_green_space, :space_not_available, :blueprint)
    end
end
