class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @title_modal = "Nuevo proyecto"
    @project = Project.new
    @project_type = ProjectType.actives
    @materials = Material.actives
    @providers = Provider.actives
    @sectors = Sector.where(active: true)
    @provider_roles = ProviderRole.where(active: true)
    @payment_methods = PaymentMethod.where(active: true)
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    ActiveRecord::Base.transaction do 
      project = Project.create(
        number: params[:number],
        name: params[:name],
        project_type_id: params[:project_type_id],
        description: params[:description],
        price: params[:price],
        final_price: params[:final_price]
      )
      if params[:cant_materials].to_i > 0
        materials = params[:cant_materials].to_i - 1
        for i in 0..materials do 
          project.project_materials.create(
            material_id: params["material_id_#{i}".to_sym].to_i,
            units: params["material_units_#{i}".to_sym].to_i,
            price: params["material_price__#{i}".to_sym].to_i
          )
        end
      end

      if params[:cant_providers].to_i > 0
        providers = params[:cant_providers].to_i - 1
        for i in 0..providers do 
          project.project_providers.create(
            provider_id: params["provider_id_#{i}".to_sym].to_i,
            provider_roles_id: params["provider_role_id_#{i}".to_sym].to_i,
            payment_methods_id: params["payment_method_id_#{i}".to_sym].to_i,
            price: params["provider_price_#{i}".to_sym].to_i,
            iva: params["provider_iva_#{i}".to_sym].to_i,
            price_calculate: params["provider_price_calculate_#{i}".to_sym].to_i,
            porcent: params["provider_porcent_#{i}".to_sym].to_i
          )
        end
      end

    end # transaction

    rescue => e
      @response = e.message.split(':')
      render json: {status: 'error', msg: 'No se pudo registrar el proyecto'}, status: 402
      byebug
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:number, :name, :tecnical_direction, :provider_id, :material_id, :active, :price, :status)
    end
end
