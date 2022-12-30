class VersionsController < ApplicationController
  before_action :set_version, only: [:show, :edit, :update, :destroy]

  # GET /versions
  # GET /versions.json
   def import
     Version.import(params[:file])
       redirect_to root_url, notice: "importadas."
   end 
  
  def index
    
     if params[:search] and params[:search] != ""

          @versions = Version.search(params[:search]).paginate(:page => params[:page]).order(:descrip)


          puts "sssssvvvv"
     else 
        
       @versions = Version.order(:descrip).paginate(:page => params[:page])

          puts "noooo"
     end    
  

    
    respond_to do |format|
      format.html
      format.csv { send_data @versions.to_csv, filename: "Versions-#{Date.today}.csv" }
      format.xls 
    end

  end

  # GET /versions/1
  # GET /versions/1.json
  def show
    @productos = Producto.order(:name)
  end

  # GET /versions/new
  def new
    @version = Version.new
    @productos = Producto.order(:name)
    @company = Company.find(1)

     if(params[:ajax])
      @ajax = true
      render :layout => false
    end

  end

  # GET /versions/1/edit
  def edit
    @productos = Producto.order(:name)
  end


# Create via ajax
  def create_ajax

   if( params[:name] and params[:name] != "")
      @version = Version.new(:descrip  => params[:name], :producto_id => params[:producto_id])
      
      if @version.save
        render :text => "#{@version.id}|BRK|#{@version.descrip}"
      else
        render :text => "error"
      end
    else
      render :text => "error_empty"     
    end
  end


  # POST /versions
  # POST /versions.json
  def create
    @version = Version.new(version_params)
    @productos = Producto.order(:name)
    respond_to do |format|
      if @version.save
        format.html { redirect_to @version, notice: 'Version was successfully created.' }
        format.json { render :show, status: :created, location: @version }
      else
        format.html { render :new }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /versions/1
  # PATCH/PUT /versions/1.json
  def update
    respond_to do |format|
      if @version.update(version_params)
        format.html { redirect_to @version, notice: 'Version was successfully updated.' }
        format.json { render :show, status: :ok, location: @version }
      else
        format.html { render :edit }
        format.json { render json: @version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /versions/1
  # DELETE /versions/1.json
  def destroy
    @version.destroy
    respond_to do |format|
      format.html { redirect_to versions_url, notice: 'Version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  def import
      Version.import(params[:file])
       redirect_to root_url, notice: "Version  importadas."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_version
      @version = Version.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def version_params
      params.require(:version).permit(:descrip,:producto_id)
    end
end
