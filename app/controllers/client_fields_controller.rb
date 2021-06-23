class ClientFieldsController < ApplicationController
  before_action :set_client_field, only: %i[ show edit update destroy ]

  # GET /client_fields or /client_fields.json
  def index
    @client_fields = ClientField.all
  end

  # GET /client_fields/1 or /client_fields/1.json
  def show
  end

  # GET /client_fields/new
  def new
    @client_field = ClientField.new
  end

  # GET /client_fields/1/edit
  def edit
  end

  # POST /client_fields or /client_fields.json
  def create
    @client_field = ClientField.new(client_field_params)

    respond_to do |format|
      if @client_field.save
        format.html { redirect_to @client_field, notice: "Client field was successfully created." }
        format.json { render :show, status: :created, location: @client_field }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @client_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_fields/1 or /client_fields/1.json
  def update
    respond_to do |format|
      if @client_field.update(client_field_params)
        format.html { redirect_to @client_field, notice: "Client field was successfully updated." }
        format.json { render :show, status: :ok, location: @client_field }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @client_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_fields/1 or /client_fields/1.json
  def destroy
    @client_field.destroy
    respond_to do |format|
      format.html { redirect_to client_fields_url, notice: "Client field was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_field
      @client_field = ClientField.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_field_params
      params.require(:client_field).permit(:client_id, :field_id, :detail, :active)
    end
end
