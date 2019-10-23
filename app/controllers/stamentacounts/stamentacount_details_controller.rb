

class Stamentacounts::StamentacountDetailsController < ApplicationController
   before_action :set_stamentacount 
   before_action :set_stamentacount_detail , :except=> [:new,:create,:import ]
  

  # GET /stamentacount_details
  # GET /stamentacount_details.json
  def index
    @stamentacount_details = StamentacountDetail.all

      
  end

  # GET /stamentacount_details/1
  # GET /stamentacount_details/1.json
  def show
  end

  # GET /stamentacount_details/new
  def new
   
    @stamentacount_detail = StamentacountDetail.new
    @tipomov =   Tipomov.all
    @stamentacount_detail[:fecha] = Date.today
    @stamentacount_detail[:cargo] = 0.00
    @stamentacount_detail[:abono] = 0.00 


  end

  # GET /stamentacount_details/1/edit
  def edit
     @tipomov =   Tipomov.all
    
  end

  # POST /stamentacount_details
  # POST /stamentacount_details.json
  def create
    @stamentacount_detail = StamentacountDetail.new(stamentacount_detail_params)
    @stamentacount_detail.stamentacount_id  = @stamentacount.id 



      respond_to do |format|
      if @stamentacount_detail.save

          
           @stamentacount_detail[:cargo] = @stamentacount.get_subtotal("cargos")
           @stamentacount_detail[:abono] = @stamentacount.get_subtotal("abonos")
           @stamentacount[:saldo_final] = @stamentacount[:saldo_inicial] - @stamentacount_detail[:cargo] + @stamentacount_detail[:abono]
          
           @stamentacount.update_attributes(:saldo_final=> @stamentacount[:saldo_final])

        format.html { redirect_to @stamentacount, notice: 'Stamentacount detail was successfully created.' }
        format.json { render :show, status: :created, location: @stamentacount }
      else
        format.html { render :new }
        format.json { render json: @stamentacount.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamentacount_details/1
  # PATCH/PUT /stamentacount_details/1.json
  def update
    respond_to do |format|
      if @stamentacount_detail.update(stamentacount_detail_params)

           @stamentacount_detail[:cargo] = @stamentacount.get_subtotal("cargos")
           @stamentacount_detail[:abono] = @stamentacount.get_subtotal("abonos")
           @stamentacount[:saldo_final] = @stamentacount[:saldo_inicial] - @stamentacount_detail[:cargo] + @stamentacount_detail[:abono]
          
           @stamentacount.update_attributes(:saldo_final=> @stamentacount[:saldo_final])

        format.html { redirect_to @stamentacount, notice: 'Stamentacount detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @stamentacount }
      else
        format.html { render :edit }
        format.json { render json: @stamentacount.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamentacount_details/1
  # DELETE /stamentacount_details/1.json

  def destroy
    
    if @stamentacount_detail.destroy 

           @stamentacount[:saldo_final] = @stamentacount[:saldo_inicial] - @stamentacount.get_subtotal("cargos") + @stamentacount.get_subtotal("abonos")
          
           @stamentacount.update_attributes(:saldo_final=> @stamentacount[:saldo_final])

      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @stamentacount
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show 
    end 

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamentacount
      @stamentacount  = Stamentacount.find(params[:stamentacount_id])
    end 
   
    def set_stamentacount_detail
      @stamentacount_detail = StamentacountDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stamentacount_detail_params
      params.require(:stamentacount_detail).permit(:fecha, :tipomov_id, :cargo, :abono, :concepto, :nrocheque)
    end
end
