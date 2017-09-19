class Ordens::OrdensProductsController < ApplicationController
   before_action :set_orden 
   before_action :set_orden_product, :except=> [:new,:create]
   
  # GET /orden_products/1
  # GET /orden_products/1.json
  
  # GET /orden_products/new
  def new
    
    @orden_product = OrdenProduct.new
    @company = Company.find(1)
    @orden_product.d01 = 0
    @orden_product.d02 = 0
    @orden_product.d03 = 0
    @orden_product.d04 = 0
    @orden_product.d05 = 0
    @orden_product.d06 = 0
    @orden_product.d07 = 0
    @orden_product.d08 = 0
    @orden_product.d09 = 0
    @orden_product.d10 = 0
    @orden_product.d11 = 0
    @orden_product.d12 = 0
    @orden_product.d13 = 0
    @orden_product.d14 = 0
    @orden_product.d15 = 0
    @orden_product.d16 = 0
    @orden_product.d17 = 0
    @orden_product.d18 = 0
    @orden_product.d19 = 0
    @orden_product.d20 = 0
    @orden_product.d21 = 0
    @orden_product.d22 = 0
    @orden_product.d23 = 0
    @orden_product.d24 = 0
    @orden_product.d25 = 0
    @orden_product.d26 = 0
    @orden_product.d27 = 0
    @orden_product.d28 = 0
    @orden_product.d29 = 0
    @orden_product.d30 = 0
    @orden_product.d31 = 0
    @orden_product.quantity = 0
    @orden_product.tarifa = 0
    @orden_product.price = 0
    @orden_product.total = 0
  end

  # GET /orden_products/1/edit
  def edit
    @company = Company.find(1)
    @aviso = Avisodetail.find(@orden_product.avisodetail_id)
    @ac_item = @aviso.descrip
    @ac_item_id = @aviso.id
    
   
  end

  # POST /orden_products
  # POST /orden_products.json
  def create
    
    
    @orden_product = OrdenProduct.new(orden_product_params)
    @orden_product.orden_id  = @orden.id 
    @orden_product.avisodetail_id = params[:ac_item_id]
    @orden_product.price = (@orden_product.tarifa / 30 * @orden.tiempo )
    @company = Company.find(1)
    sum_dias = (@orden_product.d01 + @orden_product.d02 + @orden_product.d03 + @orden_product.d04+ 
                @orden_product.d05 + @orden_product.d06 + @orden_product.d07 + @orden_product.d08+
                @orden_product.d09 + @orden_product.d10 + @orden_product.d11 + @orden_product.d12+
                @orden_product.d13 + @orden_product.d14 + @orden_product.d15 + @orden_product.d16+
                @orden_product.d17 + @orden_product.d18 + @orden_product.d19 + @orden_product.d20+
                @orden_product.d21 + @orden_product.d22 + @orden_product.d23 + @orden_product.d24+
                @orden_product.d25 + @orden_product.d26 + @orden_product.d27 + @orden_product.d28+
                @orden_product.d29 + @orden_product.d30 + @orden_product.d31)
    @orden_product.quantity = sum_dias 
    @orden_product.total = @orden_product.price * sum_dias
    
     respond_to do |format|
       if @orden_product.save
         format.html { redirect_to @orden, notice: 'Orden product was successfully created.' }
         format.json { render :show, status: :created, location: @orden }
       else
         format.html { render :new }
         format.json { render json: @orden.errors, status: :unprocessable_entity }
       end
     end
  end

  # PATCH/PUT /orden_products/1
  # PATCH/PUT /orden_products/1.json
  def update
    @orden = Orden.find(params[:orden_id])
    @orden_product = OrdenProduct.find(params[:id]) 
    @orden_product[:avisodetail_id] = params[:ac_item_id]
    @orden_product[:price] = (@orden_product.tarifa / 30 * @orden.tiempo )
    @company = Company.find(1)
    sum_dias = (@orden_product.d01 + @orden_product.d02 + @orden_product.d03 + @orden_product.d04+ 
                @orden_product.d05 + @orden_product.d06 + @orden_product.d07 + @orden_product.d08+
                @orden_product.d09 + @orden_product.d10 + @orden_product.d11 + @orden_product.d12+
                @orden_product.d13 + @orden_product.d14 + @orden_product.d15 + @orden_product.d16+
                @orden_product.d17 + @orden_product.d18 + @orden_product.d19 + @orden_product.d20+
                @orden_product.d21 + @orden_product.d22 + @orden_product.d23 + @orden_product.d24+
                @orden_product.d25 + @orden_product.d26 + @orden_product.d27 + @orden_product.d28+
                @orden_product.d29 + @orden_product.d30 + @orden_product.d31)
                
    @orden_product[:quantity] = sum_dias 
    @orden_product[:total] = @orden_product.price * sum_dias
      puts "update"
      puts @orden_product[:price]
      puts @orden_product[:avisodetail_id] 
      puts @orden_product[:quantity]
      puts @orden_product[:total]
      
    respond_to do |format|
      if @orden_product.update(orden_product_params)
        format.html { redirect_to @orden, notice: 'Orden product was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden }
      else
        format.html { render :edit }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orden_products/1
  # DELETE /orden_products/1.json
  def destroy
    
    @company = Company.find(1)
    
    title =@orden_product.avisodetail.descrip 
    
    if @orden_product.destroy
      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @orden 
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show 
    end 
    
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden 
      @orden = Orden.find(params[:orden_id])
    end 
    def set_orden_product
      @orden_product = OrdenProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_product_params
      params.require(:orden_product).permit(:avisodetail_id, :price, :quantity, :total, :fecha, :tarifa, :i, :dia, :d01, :d02, :d03, :d04, :d05, :d06, :d07, :d08, :d09, :d10, :d11, :d12, :d13, :d14, :d15, :d16, :d17, :d18, :d19, :d20, :d21, :d22, :d23, :d24, :d25, :d26, :d27, :d28, :d29, :d30, :d31 )
    end
end
