class OrdenComisionsController < ApplicationController
  before_action :set_orden_comision, only: [:show, :edit, :update, :destroy]

  # GET /orden_comisions
  # GET /orden_comisions.json
  def index
    @orden_comisions = OrdenComision.all
  end

  # GET /orden_comisions/1
  # GET /orden_comisions/1.json
  def show
  end

  # GET /orden_comisions/new
  def new
    @orden_comision = OrdenComision.new
  end

  # GET /orden_comisions/1/edit
  def edit
  end

  # POST /orden_comisions
  # POST /orden_comisions.json
  def create
    @orden_comision = OrdenComision.new(orden_comision_params)

    respond_to do |format|
      if @orden_comision.save
        format.html { redirect_to @orden_comision, notice: 'Orden comision was successfully created.' }
        format.json { render :show, status: :created, location: @orden_comision }
      else
        format.html { render :new }
        format.json { render json: @orden_comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orden_comisions/1
  # PATCH/PUT /orden_comisions/1.json
  def update
    respond_to do |format|
      if @orden_comision.update(orden_comision_params)
        format.html { redirect_to @orden_comision, notice: 'Orden comision was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden_comision }
      else
        format.html { render :edit }
        format.json { render json: @orden_comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orden_comisions/1
  # DELETE /orden_comisions/1.json
  def destroy
    @orden_comision.destroy
    respond_to do |format|
      format.html { redirect_to orden_comisions_url, notice: 'Orden comision was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden_comision
      @orden_comision = OrdenComision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_comision_params
      params.require(:orden_comision).permit(:code, :name)
    end
end
