class ConciliabanksController < ApplicationController
  before_action :set_conciliabank, only: [:show, :edit, :update, :destroy]

  # GET /conciliabanks
  # GET /conciliabanks.json
  def index
    @conciliabanks = Conciliabank.all.order(:fecha1)
  end


  # GET /stamentacounts/1
  # GET /stamentacounts/1.json
  def show
     @conciliabank = Conciliabank.find(params[:id])
     @conciliabank_details  = @conciliabank.conciliabank_details.order(:id)

  end

# Export serviceorder to PDF
  def pdf
    @conciliabank = Conciliabank.find(params[:id])
    company =@conciliabank.company_id
    @company =Company.find(company)
    @conciliabank_details  = @conciliabank.conciliabank_details.order(:id)
    a = BankAcount.find(@conciliabank.bank_acount_id)
    @banco_name   =  a.bank.name
    @banco_moneda =  a.moneda.description 
    @banco_cuenta =  a.number
    @fecha1 = @conciliabank.fecha1
    @fecha2 = @conciliabank.fecha2

   @saldo_inicial = @conciliabank.saldo_inicial
   @total_cargos = @conciliabank.get_subtotal("cargos")  
   @total_abonos = @conciliabank.get_subtotal("abonos")
   @saldo =  @saldo_inicial - @total_cargos + @total_abonos 


    render  pdf: "rpt_concilia",template: "supplier_payments/rpt_banco_2.pdf.erb",locals: {:supplierpayments => @conciliabank},
      :orientation      => 'Portrait',
         :header => {
           :spacing => 5,
                           :html => {
                     :template => 'layouts/pdf-headers.html',
                           right: '[page] of [topage]'
                  }                  
               } 


  

  end
  


  # GET /stamentacounts/new
  def new
     @company = Company.find(1)
     @conciliabank = Conciliabank.new
     @bank_acounts = @company.get_bank_acounts()

     @conciliabank[:saldo_inicial] = 0.00
     @conciliabank[:saldo_final] = 0.00
     @conciliabank[:fecha1] = Date.today
     @conciliabank[:fecha2] = Date.today
     @conciliabank[:user_id] = 1
     @conciliabank[:company_id] = 1 

  end


  # GET /stamentacounts/1/edit
  def edit
    @company = Company.find(1)
    
    @bank_acounts = @company.get_bank_acounts()
    puts "edit conciliabank"
    puts @bank_acounts.first.number 

  end

  # POST /stamentacounts
  # POST /stamentacounts.json
  def create

    @conciliabank = Conciliabank.new(conciliabank_params)
    @conciliabank[:user_id] = 1
    @conciliabank[:company_id] = 1 

    respond_to do |format|
      if @conciliabank.save

        format.html { redirect_to @conciliabank, notice: 'Item de movimiento fue creado exitosament  ' }
        format.json { render :show, status: :created, location: @conciliabank }
      else
        format.html { render :new }
        format.json { render json: @conciliabank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamentacounts/1
  # PATCH/PUT /stamentacounts/1.json
  def update
   @company = Company.find(1)
    
   @bank_acounts = @company.get_bank_acounts()
    respond_to do |format|
      if @conciliabank.update(conciliabank_params)

           @conciliabank[:cargos] = @conciliabank.get_subtotal("cargos")
           @conciliabank[:abonos] = @conciliabank.get_subtotal("abonos")
           @conciliabank[:saldo_final] = @conciliabank[:saldo_inicial] - @conciliabank[:cargos] + @conciliabank[:abonos]
          
           @conciliabank.update_attributes(:saldo_final=> @conciliabank[:saldo_final])
           
        format.html { redirect_to @conciliabank, notice: 'Conciliabank was successfully updated.' }
        format.json { render :show, status: :ok, location: @conciliabank }
      else
        format.html { render :edit }
        format.json { render json: @conciliabank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamentacounts/1
  # DELETE /stamentacounts/1.json
  def destroy
           @conciliabank.destroy

          
    respond_to do |format|
      format.html { redirect_to conciliabanks_url, notice: 'Conciliabank was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def do_process 
    
    @conciliabank = Conciliabank.find(params[:id])

    fecha1 = @conciliabank.fecha1.to_date 
    fecha2 = @conciliabank.fecha2.to_date
    banco  = @conciliabank.bank_acount_id 

    puts "fecha do process "

    puts fecha1
    puts fecha2 
    puts banco 

    @conciliabank.process(fecha1,fecha2,banco)
    
    @user_id = @current_user.id 
    flash[:notice] = "La informacion ha sido agregada."
    redirect_to @conciliabank
    
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conciliabank
      @conciliabank = Conciliabank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conciliabank_params
      params.require(:conciliabank).permit(:bank_acount_id, :fecha1, :fecha2, :saldo_inicial, :saldo_final, :user_id, :company_id,:importado)
    end

end
