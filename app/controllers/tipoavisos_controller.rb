class TipoavisosController < ApplicationController
  before_action :set_tipoaviso, only: [:show, :edit, :update, :destroy]


  def import
      Customer.import(params[:file])
       redirect_to root_url, notice: "Clientes importadas."
  end 
  

  # GET /tipoavisos
  # GET /tipoavisos.json
  def index
    @tipoavisos = Tipoaviso.all
  end

  # GET /tipoavisos/1
  # GET /tipoavisos/1.json
  def show
  end

  # GET /tipoavisos/new
  def new
    @tipoaviso = Tipoaviso.new
  end

  # GET /tipoavisos/1/edit
  def edit
  end

  # POST /tipoavisos
  # POST /tipoavisos.json
  def create
    @tipoaviso = Tipoaviso.new(tipoaviso_params)

    respond_to do |format|
      if @tipoaviso.save
        format.html { redirect_to @tipoaviso, notice: 'Tipoaviso was successfully created.' }
        format.json { render :show, status: :created, location: @tipoaviso }
      else
        format.html { render :new }
        format.json { render json: @tipoaviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipoavisos/1
  # PATCH/PUT /tipoavisos/1.json
  def update
    respond_to do |format|
      if @tipoaviso.update(tipoaviso_params)
        format.html { redirect_to @tipoaviso, notice: 'Tipoaviso was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipoaviso }
      else
        format.html { render :edit }
        format.json { render json: @tipoaviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipoavisos/1
  # DELETE /tipoavisos/1.json
  def destroy
    @tipoaviso.destroy
    respond_to do |format|
      format.html { redirect_to tipoavisos_url, notice: 'Tipoaviso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipoaviso
      @tipoaviso = Tipoaviso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipoaviso_params
      params.require(:tipoaviso).permit(:descrip, :comments)
    end
end
