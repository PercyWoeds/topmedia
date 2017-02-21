class ContratoCuotaController < ApplicationController
  before_action :set_contrato_cuotum, only: [:show, :edit, :update, :destroy]

  # GET /contrato_cuota
  # GET /contrato_cuota.json
  def index
    @contrato_cuota = ContratoCuotum.all
  end

  # GET /contrato_cuota/1
  # GET /contrato_cuota/1.json
  def show
  end

  # GET /contrato_cuota/new
  def new
    @contrato_cuotum = ContratoCuotum.new
  end

  # GET /contrato_cuota/1/edit
  def edit
  end

  # POST /contrato_cuota
  # POST /contrato_cuota.json
  def create
    @contrato_cuotum = ContratoCuotum.new(contrato_cuotum_params)

    respond_to do |format|
      if @contrato_cuotum.save
        format.html { redirect_to @contrato_cuotum, notice: 'Contrato cuotum was successfully created.' }
        format.json { render :show, status: :created, location: @contrato_cuotum }
      else
        format.html { render :new }
        format.json { render json: @contrato_cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contrato_cuota/1
  # PATCH/PUT /contrato_cuota/1.json
  def update
    respond_to do |format|
      if @contrato_cuotum.update(contrato_cuotum_params)
        format.html { redirect_to @contrato_cuotum, notice: 'Contrato cuotum was successfully updated.' }
        format.json { render :show, status: :ok, location: @contrato_cuotum }
      else
        format.html { render :edit }
        format.json { render json: @contrato_cuotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contrato_cuota/1
  # DELETE /contrato_cuota/1.json
  def destroy
    @contrato_cuotum.destroy
    respond_to do |format|
      format.html { redirect_to contrato_cuota_url, notice: 'Contrato cuotum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contrato_cuotum
      @contrato_cuotum = ContratoCuotum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contrato_cuotum_params
      params.require(:contrato_cuotum).permit(:nro, :fecha, :cuota, :vventa, :comision1, :comision2, :total, :facturacanal, :factura1, :factura2)
    end
end
