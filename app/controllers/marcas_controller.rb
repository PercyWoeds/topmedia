class MarcasController < ApplicationController
  before_action :set_marca, only: [:show, :edit, :update, :destroy]

  # GET /marcas
  # GET /marcas.json
  def index
    @marcas = Marca.all
  end

  # GET /marcas/1
  # GET /marcas/1.json
  def show
    @customers = Customer.order(:name)
  end

  # GET /marcas/new
  def new
    @marca = Marca.new
    @customers = Customer.order(:name)
    @company = Company.find(1)

     if(params[:ajax])
      @ajax = true
      render :layout => false
    end
  end

  # GET /marcas/1/edit
  def edit
    @customers = Customer.order(:name)
  end
# Create via ajax
  def create_ajax

   if( params[:name] and params[:name] != "")
      @marca = Marca.new(:name => params[:name], :customer_id => params[:customer_id])
      
      if @marca.save


        render :text => "#{@marca.id}|BRK|#{@marca.name}"
      else
        render :text => "error"
      end
    else
      render :text => "error_empty"
      puts "eeeeeeeeeee"
      puts params[:name] 
    end
  end


  # POST /marcas
  # POST /marcas.json
  def create
    @marca = Marca.new(marca_params)
    @customers = Customer.order(:name)
    
    respond_to do |format|
      if @marca.save
        format.html { redirect_to @marca, notice: 'Marca was successfully created.' }
        format.json { render :show, status: :created, location: @marca }
      else
        format.html { render :new }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marcas/1
  # PATCH/PUT /marcas/1.json
  def update
    respond_to do |format|
      if @marca.update(marca_params)
        format.html { redirect_to @marca, notice: 'Marca was successfully updated.' }
        format.json { render :show, status: :ok, location: @marca }
      else
        format.html { render :edit }
        format.json { render json: @marca.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marcas/1
  # DELETE /marcas/1.json
  def destroy
    @marca.destroy
    respond_to do |format|
      format.html { redirect_to marcas_url, notice: 'Marca was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def import
      Marca.import(params[:file])
       redirect_to root_url, notice: "Marcas  importadas."
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marca
      @marca = Marca.find(params[:id])
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marca_params
      params.require(:marca).permit(:name,:customer_id)
    end
end
