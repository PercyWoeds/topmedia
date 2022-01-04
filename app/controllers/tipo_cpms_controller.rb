class TipoCpmsController < ApplicationController
  before_action :set_tipo_cpm, only: [:show, :edit, :update, :destroy]

  # GET /tipo_cpms
  # GET /tipo_cpms.json
  def index
    @tipo_cpms = TipoCpm.all
  end

  # GET /tipo_cpms/1
  # GET /tipo_cpms/1.json
  def show
  end

  # GET /tipo_cpms/new
  def new
    @tipo_cpm = TipoCpm.new
  end

  # GET /tipo_cpms/1/edit
  def edit
  end

  # POST /tipo_cpms
  # POST /tipo_cpms.json
  def create
    @tipo_cpm = TipoCpm.new(tipo_cpm_params)

    respond_to do |format|
      if @tipo_cpm.save
        format.html { redirect_to @tipo_cpm, notice: 'Tipo cpm was successfully created.' }
        format.json { render :show, status: :created, location: @tipo_cpm }
      else
        format.html { render :new }
        format.json { render json: @tipo_cpm.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tipo_cpms/1
  # PATCH/PUT /tipo_cpms/1.json
  def update
    respond_to do |format|
      if @tipo_cpm.update(tipo_cpm_params)
        format.html { redirect_to @tipo_cpm, notice: 'Tipo cpm was successfully updated.' }
        format.json { render :show, status: :ok, location: @tipo_cpm }
      else
        format.html { render :edit }
        format.json { render json: @tipo_cpm.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_cpms/1
  # DELETE /tipo_cpms/1.json
  def destroy
    @tipo_cpm.destroy
    respond_to do |format|
      format.html { redirect_to tipo_cpms_url, notice: 'Tipo cpm was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tipo_cpm
      @tipo_cpm = TipoCpm.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tipo_cpm_params
      params.require(:tipo_cpm).permit(:code, :name)
    end
end
