class TipoTarifasController < ApplicationController
  before_action :set_tipo_tarifa, only: [:show, :edit, :update, :destroy]

  # GET /tipo_tarifas
  # GET /tipo_tarifas.json
  def index
    @tipo_tarifas = TipoTarifa.all
  end

  # GET /tipo_tarifas/1
  # GET /tipo_tarifas/1.json
  def show
  end

  # GET /tipo_tarifas/new
  def new
    @tipo_tarifa = TipoTarifa.new
  end

  # GET /tipo_tarifas/1/edit
  def edit
  end

  # POST /tipo_tarifas
  # POST /tipo_tarifas.json
  def create
    @tipo_tarifa = TipoTarifa.new(tipo_tarifa_params)

    respond_to do |format|
      if @tipo_tarifa.save
        format.html { redirect_to @tipo_tarifa, notice: 'Tipo tarifa was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_tarifa }
      else
        format.html { render :new }
        format.json { render json: @tipo_tarifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_tarifas/1
  # PATCH/PUT /tipo_tarifas/1.json
  def update
    respond_to do |format|
      if @tipo_tarifa.update(tipo_tarifa_params)
        format.html { redirect_to @tipo_tarifa, notice: 'Tipo tarifa was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_tarifa }
      else
        format.html { render :edit }
        format.json { render json: @tipo_tarifa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_tarifas/1
  # DELETE /tipo_tarifas/1.json
  def destroy
    @tipo_tarifa.destroy
    respond_to do |format|
      format.html { redirect_to tipo_tarifas_url, notice: 'Tipo tarifa was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_tarifa
      @tipo_tarifa = TipoTarifa.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_tarifa_params
      params.require(:tipo_tarifa).permit(:code, :name, :user_id)
    end
end
