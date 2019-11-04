class ConciliationsController < ApplicationController
  before_action :set_conciliation, only: [:show, :edit, :update, :destroy]

  # GET /conciliations
  # GET /conciliations.json
  def index
    @conciliations = Conciliation.all
  end

  # GET /conciliations/1
  # GET /conciliations/1.json
  def show
  end

  # GET /conciliations/new
  def new
    @conciliation = Conciliation.new
  end

  # GET /conciliations/1/edit
  def edit
  end

  # POST /conciliations
  # POST /conciliations.json
  def create
    @conciliation = Conciliation.new(conciliation_params)

    respond_to do |format|
      if @conciliation.save
        format.html { redirect_to @conciliation, notice: 'Conciliation was successfully created.' }
        format.json { render :show, status: :created, location: @conciliation }
      else
        format.html { render :new }
        format.json { render json: @conciliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conciliations/1
  # PATCH/PUT /conciliations/1.json
  def update
    respond_to do |format|
      if @conciliation.update(conciliation_params)
        format.html { redirect_to @conciliation, notice: 'Conciliation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conciliation }
      else
        format.html { render :edit }
        format.json { render json: @conciliation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conciliations/1
  # DELETE /conciliations/1.json
  def destroy
    @conciliation.destroy
    respond_to do |format|
      format.html { redirect_to conciliations_url, notice: 'Conciliation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conciliation
      @conciliation = Conciliation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conciliation_params
      params.require(:conciliation).permit(:fecha1, :fecha2, :saldo_inicial, :saldo_final, :user_id, :company_id, :bank_acount_id)
    end
end
