class QuotaController < ApplicationController
  before_action :set_quotum, only: [:show, :edit, :update, :destroy]

  # GET /quota
  # GET /quota.json
  def index
    @quota = Quotum.all
  end

  # GET /quota/1
  # GET /quota/1.json
  def show
  end

  # GET /quota/new
  def new
    @quotum = Quotum.new
  end

  # GET /quota/1/edit
  def edit
  end

  # POST /quota
  # POST /quota.json
  def create
    @quotum = Quotum.new(quotum_params)

    respond_to do |format|
      if @quotum.save
        format.html { redirect_to @quotum, notice: 'Quotum was successfully created.' }
        format.json { render :show, status: :created, location: @quotum }
      else
        format.html { render :new }
        format.json { render json: @quotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quota/1
  # PATCH/PUT /quota/1.json
  def update
    respond_to do |format|
      if @quotum.update(quotum_params)
        format.html { redirect_to @quotum, notice: 'Quotum was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotum }
      else
        format.html { render :edit }
        format.json { render json: @quotum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quota/1
  # DELETE /quota/1.json
  def destroy
    @quotum.destroy
    respond_to do |format|
      format.html { redirect_to quota_url, notice: 'Quotum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotum
      @quotum = Quotum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quotum_params
      params.require(:quotum).permit(:nro, :fecha, :importe, :vventa, :comision1, :comision2, :total, :facturacanal, :fecha2, :factura1, :factura2)
    end
end
