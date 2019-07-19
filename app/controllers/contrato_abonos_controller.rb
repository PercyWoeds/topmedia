class ContratoAbonosController < ApplicationController
  before_action :set_contrato_abono, only: [:show, :edit, :update, :destroy]

  # GET /contrato_abonos
  # GET /contrato_abonos.json
  def index
    @contrato_abonos = ContratoAbono.all
  end

  # GET /contrato_abonos/1
  # GET /contrato_abonos/1.json
  def show
  end

  # GET /contrato_abonos/new
  def new
    @contrato_abono = ContratoAbono.new

    @customers = Customer.all.order(:name) 
    @monedas = Moneda.all
    @medios =Medio.all.order(:descrip)
    @customercontrato = CustomerContrato.all.order(:secu_cont) 
    @contrato_abono[:fecha] = Date.today
  end

  # GET /contrato_abonos/1/edit
  def edit

    @customers = Customer.all.order(:name) 
    @monedas = Moneda.all
    @medios =Medio.all.order(:descrip)
    @customercontrato = CustomerContrato.all.order(:secu_cont)
    
  end

  # POST /contrato_abonos
  # POST /contrato_abonos.json
  def create
    @contrato_abono = ContratoAbono.new(contrato_abono_params)

    @customers = Customer.all.order(:name) 
    @monedas = Moneda.all
    @medios =Medio.all.order(:descrip)
    @customercontrato = CustomerContrato.all.order(:secu_cont)
    

    respond_to do |format|
      if @contrato_abono.save
        format.html { redirect_to @contrato_abono, notice: 'Contrato abono was successfully created.' }
        format.json { render :show, status: :created, location: @contrato_abono }
      else
        format.html { render :new }
        format.json { render json: @contrato_abono.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contrato_abonos/1
  # PATCH/PUT /contrato_abonos/1.json
  def update

    @customers = Customer.all.order(:name) 
    @monedas = Moneda.all
    @medios =Medio.all.order(:descrip)
    @customercontrato = CustomerContrato.all.order(:secu_cont)
    

    respond_to do |format|
      if @contrato_abono.update(contrato_abono_params)
        format.html { redirect_to @contrato_abono, notice: 'Contrato abono was successfully updated.' }
        format.json { render :show, status: :ok, location: @contrato_abono }
      else
        format.html { render :edit }
        format.json { render json: @contrato_abono.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contrato_abonos/1
  # DELETE /contrato_abonos/1.json
  def destroy
    @contrato_abono.destroy
    respond_to do |format|
      format.html { redirect_to contrato_abonos_url, notice: 'Contrato abono was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contrato_abono
      @contrato_abono = ContratoAbono.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contrato_abono_params
      params.require(:contrato_abono).permit(:fecha, :customer_id, :medio_id, :secu_cont, :observa, :importe, :moneda_id)
    end
end
