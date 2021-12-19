class MedioCustomersController < ApplicationController
  before_action :set_medio_customer, only: [:show, :edit, :update, :destroy]

  # GET /medio_customers
  # GET /medio_customers.json
  def index
    @medio_customers = MedioCustomer.all
  end

  # GET /medio_customers/1
  # GET /medio_customers/1.json
  def show
  end

  # GET /medio_customers/new
  def new
    @medio_customer = MedioCustomer.new
    @medios =  Medio.all.order(:descrip)
    @customers = Customer.all.order(:name)
    @medio_customer[:comision1] = 5
    @medio_customer[:comision2] = 0




  end

  # GET /medio_customers/1/edit
  def edit
    @medios =  Medio.all.order(:descrip)
    @customers = Customer.all.order(:name)

  end

  # POST /medio_customers
  # POST /medio_customers.json
  def create
    @medio_customer = MedioCustomer.new(medio_customer_params)

    respond_to do |format|
      if @medio_customer.save
        format.html { redirect_to @medio_customer, notice: 'Medio customer was successfully created.' }
        format.json { render :show, status: :created, location: @medio_customer }
      else
        format.html { render :new }
        format.json { render json: @medio_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medio_customers/1
  # PATCH/PUT /medio_customers/1.json
  def update
    respond_to do |format|
      if @medio_customer.update(medio_customer_params)
        format.html { redirect_to @medio_customer, notice: 'Medio customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @medio_customer }
      else
        format.html { render :edit }
        format.json { render json: @medio_customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medio_customers/1
  # DELETE /medio_customers/1.json
  def destroy
    @medio_customer.destroy
    respond_to do |format|
      format.html { redirect_to medio_customers_url, notice: 'Medio customer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medio_customer
      @medio_customer = MedioCustomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medio_customer_params
      params.require(:medio_customer).permit(:medio_id, :customer_id, :comision1, :comision2)
    end
end
