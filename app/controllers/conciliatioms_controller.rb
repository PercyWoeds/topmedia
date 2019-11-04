class ConciliatiomsController < ApplicationController
  before_action :set_conciliatiom, only: [:show, :edit, :update, :destroy]

  # GET /conciliatioms
  # GET /conciliatioms.json
  def index
    @conciliatioms = Conciliatiom.all
  end

  # GET /conciliatioms/1
  # GET /conciliatioms/1.json
  def show
  end

  # GET /conciliatioms/new
  def new
    @conciliatiom = Conciliatiom.new
  end

  # GET /conciliatioms/1/edit
  def edit
  end

  # POST /conciliatioms
  # POST /conciliatioms.json
  def create
    @conciliatiom = Conciliatiom.new(conciliatiom_params)

    respond_to do |format|
      if @conciliatiom.save
        format.html { redirect_to @conciliatiom, notice: 'Conciliatiom was successfully created.' }
        format.json { render :show, status: :created, location: @conciliatiom }
      else
        format.html { render :new }
        format.json { render json: @conciliatiom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conciliatioms/1
  # PATCH/PUT /conciliatioms/1.json
  def update
    respond_to do |format|
      if @conciliatiom.update(conciliatiom_params)
        format.html { redirect_to @conciliatiom, notice: 'Conciliatiom was successfully updated.' }
        format.json { render :show, status: :ok, location: @conciliatiom }
      else
        format.html { render :edit }
        format.json { render json: @conciliatiom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conciliatioms/1
  # DELETE /conciliatioms/1.json
  def destroy
    @conciliatiom.destroy
    respond_to do |format|
      format.html { redirect_to conciliatioms_url, notice: 'Conciliatiom was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conciliatiom
      @conciliatiom = Conciliatiom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conciliatiom_params
      params.require(:conciliatiom).permit(:fecha1, :fecha2, :saldo_inicial, :saldo_final, :user_id, :company_id, :bank_acount_id)
    end
end
