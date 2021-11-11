class TipoAvisosController < ApplicationController
  before_action :set_tipo_aviso, only: [:show, :edit, :update, :destroy]

  # GET /tipo_avisos
  # GET /tipo_avisos.json
  def index
    @tipo_avisos = TipoAviso.all
  end

  # GET /tipo_avisos/1
  # GET /tipo_avisos/1.json
  def show
  end

  # GET /tipo_avisos/new
  def new
    @tipo_aviso = TipoAviso.new
  end

  # GET /tipo_avisos/1/edit
  def edit
  end

  # POST /tipo_avisos
  # POST /tipo_avisos.json
  def create
    @tipo_aviso = TipoAviso.new(tipo_aviso_params)

    respond_to do |format|
      if @tipo_aviso.save
        format.html { redirect_to @tipo_aviso, notice: 'Tipo aviso was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_aviso }
      else
        format.html { render :new }
        format.json { render json: @tipo_aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_avisos/1
  # PATCH/PUT /tipo_avisos/1.json
  def update
    respond_to do |format|
      if @tipo_aviso.update(tipo_aviso_params)
        format.html { redirect_to @tipo_aviso, notice: 'Tipo aviso was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_aviso }
      else
        format.html { render :edit }
        format.json { render json: @tipo_aviso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_avisos/1
  # DELETE /tipo_avisos/1.json
  def destroy
    @tipo_aviso.destroy
    respond_to do |format|
      format.html { redirect_to tipo_avisos_url, notice: 'Tipo aviso was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_aviso
      @tipo_aviso = TipoAviso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_aviso_params
      params.require(:tipo_aviso).permit(:code, :name, :user_id)
    end
end
