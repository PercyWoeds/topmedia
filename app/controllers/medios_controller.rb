class MediosController < ApplicationController
  before_action :set_medio, only: [:show, :edit, :update, :destroy]

  # GET /medios
  # GET /medios.json
  def index
    @medios = Medio.order(:id)
  end

  # GET /medios/1
  # GET /medios/1.json
  def show
  end

  # GET /medios/new
  def new
    @medio = Medio.new
  end

  # GET /medios/1/edit
  def edit
  end

  # POST /medios
  # POST /medios.json
  def create
    @medio = Medio.new(medio_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medio
      @medio = Medio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medio_params
      params.require(:medio).permit(:descrip, :comments,:grupo,:estacion,:full_name)
    end
end
