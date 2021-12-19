class Facturas::FacturasDetailsController < ApplicationController
  
   before_action :set_factura 
   before_action :set_factura_detail, :except=> [:new,:create]
   
  # GET /factura_details
  # GET /factura_details.json
  def index
    @factura_details = FacturaDetail.all
  end

  # GET /factura_details/1
  # GET /factura_details/1.json
  def show
     
  end

  # GET /factura_details/new
  def new
    
    @contrato_cuotas= ContratoDetail.where(:contrato_id => @invoice.contrato_id) 
    
    @factura_detail = FacturaDetail.new
    
 end 

  # GET /factura_details/1/edit
  def edit
  end

  # POST /factura_details
  # POST /factura_details.json
  def create
    
    
    a =params["ac_contrato_cuota_id"]
    @factura_detail = FacturaDetail.new(factura_detail_params)
    @factura_detail.factura_id  = @factura.id 
    @factura_detail.contrato_cuota_id   = a 
    
    
    respond_to do |format|
      if @factura_detail.save
        format.html { redirect_to @factura, notice: 'Factura detail was successfully created.' }
        format.json { render :show, status: :created, location: @factura }
      else
        format.html { render :new }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factura_details/1
  # PATCH/PUT /factura_details/1.json
  def update
    respond_to do |format|
      if @factura_detail.update(factura_detail_params)
        format.html { redirect_to @factura, notice: 'Factura detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @factura}
      else
        format.html { render :edit }
        format.json { render json: @factura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factura_details/1
  # DELETE /factura_details/1.json
  def destroy

  
    if @factura_detail.destroy

       a =Orden.find(@factura_detail.orden_id)
       a.processed = "1"
       a.save 


    end 

    @factura[:subtotal] =  @factura.get_subtotal

    @factura[:total] = @factura[:subtotal] * 1.18 
    
    @factura[:tax]   = @factura[:total]  - @factura[:subtotal] 

    
   if @factura_detail.destroy
      @factura.update_attributes(subtotal: @factura[:subtotal].round(2) ,total: @factura[:total].round(2), tax: @factura[:tax].round(2)) 

      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @factura
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show 
    end 
  end
 
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factura
      @factura = Factura.find(params[:factura_id])
    end 
  
    def set_factura_detail
      @factura_detail = FacturaDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def factura_detail_params
      params.require(:factura_detail).permit(:factura_id, :contrato_cuota_id, :total, :moneda_id, :tipocambio)
    end
end
