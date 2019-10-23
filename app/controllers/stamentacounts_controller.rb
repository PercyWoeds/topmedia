class StamentacountsController < ApplicationController
  before_action :set_stamentacount, only: [:show, :edit, :update, :destroy]

  # GET /stamentacounts
  # GET /stamentacounts.json
  def index
    @stamentacounts = Stamentacount.all
  end


  # GET /stamentacounts/1
  # GET /stamentacounts/1.json
  def show
     @stamentacount = Stamentacount.find(params[:id])
     @stamentacount_details  = @stamentacount.stamentacount_details.order(:id)

  end

  # GET /stamentacounts/new
  def new
     @company = Company.find(1)
     @stamentacount = Stamentacount.new
     @bank_acounts = @company.get_bank_acounts()
     @stamentacount[:saldo_inicial] = 0.00
     @stamentacount[:saldo_final] = 0.00
     @stamentacount[:fecha1] = Date.today
     @stamentacount[:fecha2] = Date.today
     
  end

  # GET /stamentacounts/1/edit
  def edit
    @company = Company.find(1)
    @bank_acounts = @company.get_bank_acounts()

  end

  # POST /stamentacounts
  # POST /stamentacounts.json
  def create


    @stamentacount = Stamentacount.new(stamentacount_params)
    @stamentacount[:user_id] = 1
    @stamentacount[:company_id] = 1 

    respond_to do |format|
      if @stamentacount.save

          
           

        format.html { redirect_to @stamentacount, notice: 'Item de movimiento fue creado exitosament' }
        format.json { render :show, status: :created, location: @stamentacount }
      else
        format.html { render :new }
        format.json { render json: @stamentacount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamentacounts/1
  # PATCH/PUT /stamentacounts/1.json
  def update
    respond_to do |format|
      if @stamentacount.update(stamentacount_params)

           @stamentacount[:cargos] = @stamentacount.get_subtotal("cargos")
           @stamentacount[:abonos] = @stamentacount.get_subtotal("abonos")
           @stamentacount[:saldo_final] = @orden[:saldo_inicial] - @orden[:cargos] + @orden[:abonos]
          
           @stamentacount.update_attributes(:saldo_final=> @stamentacount[:saldo_final])
           
        format.html { redirect_to @stamentacount, notice: 'Stamentacount was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamentacount }
      else
        format.html { render :edit }
        format.json { render json: @stamentacount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamentacounts/1
  # DELETE /stamentacounts/1.json
  def destroy
    @stamentacount.destroy

           @stamentacount[:cargos] = @stamentacount.get_subtotal("cargos")
           @stamentacount[:abonos] = @stamentacount.get_subtotal("abonos")
           @stamentacount[:saldo_final] = @orden[:saldo_inicial] - @orden[:cargos] + @orden[:abonos]
          
           @stamentacount.update_attributes(:saldo_final=> @stamentacount[:saldo_final])
           

    respond_to do |format|
      format.html { redirect_to stamentacounts_url, notice: 'Stamentacount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamentacount
      @stamentacount = Stamentacount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamentacount_params
      params.require(:stamentacount).permit(:bank_acount_id, :fecha1, :fecha2, :saldo_inicial, :saldo_final, :user_id, :company_id)
    end
end
