class StamentacountsController < ApplicationController
  before_action :set_stamentacount, only: [:show, :edit, :update, :destroy]

  # GET /stamentacounts
  # GET /stamentacounts.json
  def index
    @stamentacounts = Stamentacount.all.order(:fecha1)
  end


  # GET /stamentacounts/1
  # GET /stamentacounts/1.json
  def show
     @stamentacount = Stamentacount.find(params[:id])
     @stamentacount_details  = @stamentacount.stamentacount_details.order(:id)

  end

# Export serviceorder to PDF
  def pdf
    @stamentacount = Stamentacount.find(params[:id])
    company =@stamentacount.company_id
    @company =Company.find(company)
    @stamentacount_details  = @stamentacount.stamentacount_details.order(:id)
    a = BankAcount.find(@stamentacount.bank_acount_id)
    @banco_name   =  a.bank.name
    @banco_moneda =  a.moneda.description 
    @banco_cuenta =  a.number
    @fecha1 = @stamentacount.fecha1
    @fecha2 = @stamentacount.fecha2

   @saldo_inicial = @stamentacount.saldo_inicial
   @total_cargos = @stamentacount.get_subtotal("cargos")  
   @total_abonos = @stamentacount.get_subtotal("abonos")
   @saldo =  @saldo_inicial - @total_cargos + @total_abonos 


    render  pdf: "rpt_concilia",template: "supplier_payments/rpt_banco_1.pdf.erb",locals: {:supplierpayments => @stamentacount},
      :orientation      => 'Portrait',
         :header => {
           :spacing => 5,
                           :html => {
                     :template => 'layouts/pdf-headers.html',
                           right: '[page] of [topage]'
                  }                  
               } ,

          :footer => { :html => { template: 'layouts/pdf-footers2.html' }       }  ,   
          :margin => {bottom: 35} 


  

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

        format.html { redirect_to @stamentacount, notice: 'Item de movimiento fue creado exitosament  ' }
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

           @cargos = @stamentacount.get_subtotal("cargos")
           @abonos = @stamentacount.get_subtotal("abonos")
           @stamentacount[:saldo_final] = @stamentacount[:saldo_inicial] - @cargos + @abonos 
          
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


  def do_process 
    
    @stamentacount = Stamentacount.find(params[:id])
    fecha1 = @stamentacount.fecha1.to_date 
    fecha2 = @stamentacount.fecha2.to_date
    banco  = @stamentacount.bank_acount_id 

    puts "fecha do process "
    puts fecha1
    puts fecha2 
    puts banco 

    @stamentacount.process(fecha1,fecha2,banco)
    
    @user_id = @current_user.id 
    flash[:notice] = "La informacion ha sido agregada."
    redirect_to @stamentacount
    
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamentacount
      @stamentacount = Stamentacount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamentacount_params
      params.require(:stamentacount).permit(:bank_acount_id, :fecha1, :fecha2, :saldo_inicial, :saldo_final, :user_id, :company_id,:importado)
    end
end
