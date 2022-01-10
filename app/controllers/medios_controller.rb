class MediosController < ApplicationController
  before_action :set_medio, only: [:show, :edit, :update, :destroy]

  # GET /medios
  # GET /medios.json
  def index
    @medios = Medio.order(:descrip)
    
    
     respond_to do |format|
      format.html
      format.csv { send_data @medios.to_csv, filename: "medios-#{Date.today}.csv" }
      format.xls 
    end
  end

  # GET /medios/1
  # GET /medios/1.json
  def show

  
  end

  # GET /medios/new
  def new
    @medio = Medio.new
    40.times {@medio.medio_details.build }
    40.times {@medio.medio_contacts.build }


  end

  # GET /medios/1/edit
  def edit
        @filters_display = "none"

     40.times {@medio.medio_details.build }
     40.times {@medio.medio_contacts.build }

  end

  # POST /medios
  # POST /medios.json
  def create
    @medio = Medio.new(medio_params)

    nroitem = 1


    respond_to do |format|
      if @medio.save

         

        format.html { redirect_to @medio, notice: 'Medio was successfully created.' }
        format.json { render :show, status: :created, location: @medio }
      else
        format.html { render :new }
        format.json { render json: @medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medios/1
  # PATCH/PUT /medios/1.json
  def update
    respond_to do |format|
      if @medio.update(medio_params)
        format.html { redirect_to @medio, notice: 'Medio was successfully updated.' }
        format.json { render :show, status: :ok, location: @medio }
      else
        format.html { render :edit }
        format.json { render json: @medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medios/1
  # DELETE /medios/1.json
  def destroy
    @medio.destroy
    respond_to do |format|
      format.html { redirect_to medios_url, notice: 'Medio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
      Medio.import(params[:file])
       redirect_to root_url, notice: "Medio importados."
  end 
  def export2
    @medio = Medio.all
    send_data @medio.to_csv  
  end 
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medio
      @medio = Medio.find(params[:id])
    end
   

    # Never trust parameters from the scary internet, only allow the white list through.
    def medio_params
      params.require(:medio).permit(:ruc,:descrip, :comments,:grupo,:estacion,:full_name,:taxable,:code  ,
         :medio_details_attributes => [:id,:code, :name  ,:user_id,:medio_id, :destroy] ,
         :medio_contacts_attributes => [:id,:code , :name , :cargo , :telefono1 , :telefono2, :telefono3, :anexo1,
         :anexo2, :anexo3, :celular1, :celular2, :celular3, :correo1, :correo2, :medio_id,:user_id, :destroy]  )


    end


     

end
