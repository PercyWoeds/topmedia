class CustomerContratosController < ApplicationController
  before_action :set_customer_contrato, only: [:show, :edit, :update, :destroy]


  # GET /customer_contratos
  # GET /customer_contratos.json
  def index
    @customer_contratos = CustomerContrato.all.order(:customer_id,:secu_cont)
   end

  def import
      CustomerContrato.import(params[:file])
       redirect_to root_url, notice: "Clientes Contratos  importadas."
  end 
  # GET /customer_contratos/1
  # GET /customer_contratos/1.json
  def show
  end

  # GET /customer_contratos/new
  def new
    @customer_contrato = CustomerContrato.new
    @customers = Customer.all.order(:name)
    @medios = Medio.all.order(:full_name)
    @contratos = Contrato.all.order(:code)
    @monedas = Moneda.all 

  end

  # GET /customer_contratos/1/edit
  def edit
     @customers = Customer.all.order(:name)
    @medios = Medio.all.order(:full_name)
    @contratos = Contrato.all.order(:code)
   @monedas = Moneda.all 

  end

  # POST /customer_contratos
  # POST /customer_contratos.json
  def create
    @customer_contrato = CustomerContrato.new(customer_contrato_params)
    @customers = Customer.all 
    @medios = Medio.all
    @contratos = Contrato.all
    @monedas = Moneda.all 


    respond_to do |format|
      if @customer_contrato.save
        format.html { redirect_to @customer_contrato, notice: 'Customer contrato was successfully created.' }
        format.json { render :show, status: :created, location: @customer_contrato }
      else
        format.html { render :new }
        format.json { render json: @customer_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_contratos/1
  # PATCH/PUT /customer_contratos/1.json
  def update
    @customers = Customer.all 
    @medios = Medio.all
    @contratos = Contrato.all
    @monedas = Moneda.all 

    respond_to do |format|
      if @customer_contrato.update(customer_contrato_params)
        format.html { redirect_to @customer_contrato, notice: 'Customer contrato was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer_contrato }
      else
        format.html { render :edit }
        format.json { render json: @customer_contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_contratos/1
  # DELETE /customer_contratos/1.json
  def destroy
    @customer_contrato.destroy
    respond_to do |format|
      format.html { redirect_to customer_contratos_url, notice: 'Customer contrato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_contrato
      @customer_contrato = CustomerContrato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_contrato_params
      params.require(:customer_contrato).permit(:customer_id, :secu_org, :medio_id, :contrato_id, :anio, :referencia, :moneda_id,:secu_cont )
    end
end
