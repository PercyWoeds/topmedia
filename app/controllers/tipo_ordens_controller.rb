class TipoOrdensController < ApplicationController
  before_action :set_tipo_orden, only: [:show, :edit, :update, :destroy]

  # GET /tipo_ordens
  # GET /tipo_ordens.json
  def index
    @tipo_ordens = TipoOrden.all
  end

  # GET /tipo_ordens/1
  # GET /tipo_ordens/1.json
  def show
  end

  # GET /tipo_ordens/new
  def new
    @tipo_orden = TipoOrden.new
  end

  # GET /tipo_ordens/1/edit
  def edit
  end

  # POST /tipo_ordens
  # POST /tipo_ordens.json
  def create
    @tipo_orden = TipoOrden.new(tipo_orden_params)

    respond_to do |format|
      if @tipo_orden.save
        format.html { redirect_to @tipo_orden, notice: 'Tipo orden was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_orden }
      else
        format.html { render :new }
        format.json { render json: @tipo_orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_ordens/1
  # PATCH/PUT /tipo_ordens/1.json
  def update
    respond_to do |format|
      if @tipo_orden.update(tipo_orden_params)
        format.html { redirect_to @tipo_orden, notice: 'Tipo orden was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_orden }
      else
        format.html { render :edit }
        format.json { render json: @tipo_orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_ordens/1
  # DELETE /tipo_ordens/1.json
  def destroy
    @tipo_orden.destroy
    respond_to do |format|
      format.html { redirect_to tipo_ordens_url, notice: 'Tipo orden was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_orden
      @tipo_orden = TipoOrden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_orden_params
      params.require(:tipo_orden).permit(:code, :descrip)
    end
end
