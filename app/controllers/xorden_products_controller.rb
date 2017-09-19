class OrdenProductsController < ApplicationController
  before_action :set_orden_product, only: [:show, :edit, :update, :destroy]

  # GET /orden_products
  # GET /orden_products.json
  def index
    @orden_products = OrdenProduct.all
  end

  # GET /orden_products/1
  # GET /orden_products/1.json
  def show
  end

  # GET /orden_products/new
  def new
    @orden_product = OrdenProduct.new
    $lcDuracion = @orden.tiempo
    
  end

  # GET /orden_products/1/edit
  def edit
  end

  # POST /orden_products
  # POST /orden_products.json
  def create
    
    @orden_product = OrdenProduct.new(orden_product_params)
    
    respond_to do |format|
      if @orden_product.save
        format.html { redirect_to @orden_product, notice: 'Orden product was successfully created.' }
        format.json { render :show, status: :created, location: @orden_product }
      else
        format.html { render :new }
        format.json { render json: @orden_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orden_products/1
  # PATCH/PUT /orden_products/1.json
  def update
    respond_to do |format|
      if @orden_product.update(orden_product_params)
        format.html { redirect_to @orden_product, notice: 'Orden product was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden_product }
      else
        format.html { render :edit }
        format.json { render json: @orden_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orden_products/1
  # DELETE /orden_products/1.json
  def destroy
    @orden_product.destroy
    respond_to do |format|
      format.html { redirect_to orden_products_url, notice: 'Orden product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_product
      @orden_product = OrdenProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_product_params
      params.require(:orden_product).permit(:avisodetail_id, :price, :quantity, :total, :fecha, :tarifa, :i, :dia, :d01, :d02, :d03, :d04, :d05, :d06, :d07, :d08, :d09, :d10, :d11, :d12, :d13, :d14, :d15, :d16, :d17, :d18, :d19, :d20, :d21, :d22, :d23, :d24, :d25, :d26, :d27, :d28, :d29, :d30, :d31 )
    end
end
