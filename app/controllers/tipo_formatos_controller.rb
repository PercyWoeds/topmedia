class TipoFormatosController < ApplicationController
  before_action :set_tipo_formato, only: [:show, :edit, :update, :destroy]

  # GET /tipo_formatos
  # GET /tipo_formatos.json
  def index
    @tipo_formatos = TipoFormato.all
  end

  # GET /tipo_formatos/1
  # GET /tipo_formatos/1.json
  def show
  end

  # GET /tipo_formatos/new
  def new
    @tipo_formato = TipoFormato.new
  end

  # GET /tipo_formatos/1/edit
  def edit
  end

  # POST /tipo_formatos
  # POST /tipo_formatos.json
  def create
    @tipo_formato = TipoFormato.new(tipo_formato_params)

    respond_to do |format|
      if @tipo_formato.save
        format.html { redirect_to @tipo_formato, notice: 'Tipo formato was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_formato }
      else
        format.html { render :new }
        format.json { render json: @tipo_formato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_formatos/1
  # PATCH/PUT /tipo_formatos/1.json
  def update
    respond_to do |format|
      if @tipo_formato.update(tipo_formato_params)
        format.html { redirect_to @tipo_formato, notice: 'Tipo formato was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_formato }
      else
        format.html { render :edit }
        format.json { render json: @tipo_formato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_formatos/1
  # DELETE /tipo_formatos/1.json
  def destroy
    @tipo_formato.destroy
    respond_to do |format|
      format.html { redirect_to tipo_formatos_url, notice: 'Tipo formato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_formato
      @tipo_formato = TipoFormato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_formato_params
      params.require(:tipo_formato).permit(:code, :name)
    end
end
