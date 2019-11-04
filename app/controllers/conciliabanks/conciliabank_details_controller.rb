

class Conciliabanks::ConciliabankDetailsController < ApplicationController
   before_action :set_conciliabank 
   before_action :set_conciliabank_detail , :except=> [:new,:create,:import ]
  

  # GET /stamentacount_details
  # GET /stamentacount_details.json
  def index
    @conciliabank_details = ConciliabankDetail.all

      
  end

  # GET /stamentacount_details/1
  # GET /stamentacount_details/1.json
  def show
  end

  # GET /stamentacount_details/new
  def new
   
    @conciliabank_detail = ConciliabankDetail.new
    @tipomov =   Tipomov.all
    @conciliabank_detail[:fecha] = Date.today
    @conciliabank_detail[:cargo] = 0.00
    @conciliabank_detail[:abono] = 0.00 


  end

  # GET /stamentacount_details/1/edit
  def edit
     @tipomov =   Tipomov.all
    
  end

  # POST /stamentacount_details
  # POST /stamentacount_details.json
  def create
    @conciliabank_detail = ConciliabankDetail.new(conciliabank_detail_params)
    @conciliabank_detail.conciliabank_id  = @conciliabank.id 



      respond_to do |format|
      if @conciliabank_detail.save

          
           @conciliabank_detail[:cargo] = @conciliabank.get_subtotal("cargos")
           @conciliabank_detail[:abono] = @conciliabank.get_subtotal("abonos")
           @conciliabank[:saldo_final] = @conciliabank[:saldo_inicial] - @conciliabank_detail[:cargo] + @conciliabank_detail[:abono]
          
           @conciliabank.update_attributes(:saldo_final=> @conciliabank[:saldo_final])

        format.html { redirect_to @conciliabank, notice: 'Concilia  detail was successfully created.' }
        format.json { render :show, status: :created, location: @conciliabank }
      else
        format.html { render :new }
        format.json { render json: @conciliabank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamentacount_details/1
  # PATCH/PUT /stamentacount_details/1.json
  def update
    respond_to do |format|
      if @conciliabank_detail.update(conciliabank_detail_params)

           @conciliabank_detail[:cargo] = @conciliabank.get_subtotal("cargos")
           @conciliabank_detail[:abono] = @conciliabank.get_subtotal("abonos")
           @conciliabank[:saldo_final] = @conciliabank[:saldo_inicial] - @conciliabank_detail[:cargo] + @conciliabank_detail[:abono]
          
           @conciliabank.update_attributes(:saldo_final=> @conciliabank[:saldo_final])

        format.html { redirect_to @conciliabank, notice: 'Detalle conciliacion fue actualizado con exito.' }
        format.json { render :show, status: :ok, location: @conciliabank }
      else
        format.html { render :edit }
        format.json { render json: @conciliabank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamentacount_details/1
  # DELETE /stamentacount_details/1.json

  def destroy
    
    
    if @conciliabank_detail.destroy 

           @conciliabank[:saldo_final] = @conciliabank[:saldo_inicial] - @conciliabank.get_subtotal("cargos") + @conciliabank.get_subtotal("abonos")
          
           @conciliabank.update_attributes(:saldo_final=> @conciliabank[:saldo_final])

      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @conciliabank
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show 
    end 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conciliabank
      @conciliabank  = Conciliabank.find(params[:conciliabank_id])
    end 
   
    def set_conciliabank_detail
      @conciliabank_detail = ConciliabankDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conciliabank_detail_params
      params.require(:conciliabank_detail).permit(:fecha, :tipomov_id, :cargo, :abono, :concepto, :nrocheque)
    end
end
