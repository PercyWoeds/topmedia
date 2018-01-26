class AvisodetailsController < ApplicationController

  before_action :set_avisodetail, only: [:show, :edit, :update, :destroy]

  def import
      Avisodetail.import(params[:file])
       redirect_to root_url, notice: "importadas."
  end 
  
  # GET /avisodetails
  # GET /avisodetails.json
  def index
    @avisodetails = Avisodetail.all
  end

  # GET /avisodetails/1
  # GET /avisodetails/1.json
  def show
  end

  # GET /avisodetails/new
  def new
    @avisodetail = Avisodetail.new
  end

  # GET /avisodetails/1/edit
  def edit
  end


  # POST /avisodetails
  # POST /avisodetails.json
  def create
    @avisodetail = Avisodetail.new(avisodetail_params)

    respond_to do |format|
      if @avisodetail.save
        format.html { redirect_to @avisodetail, notice: 'Avisodetail was successfully created.' }
        format.json { render :show, status: :created, location: @avisodetail }
      else
        format.html { render :new }
        format.json { render json: @avisodetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /avisodetails/1
  # PATCH/PUT /avisodetails/1.json
  def update
    respond_to do |format|
      if @avisodetail.update(avisodetail_params)
        format.html { redirect_to @avisodetail, notice: 'Avisodetail was successfully updated.' }
        format.json { render :show, status: :ok, location: @avisodetail }
      else
        format.html { render :edit }
        format.json { render json: @avisodetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /avisodetails/1
  # DELETE /avisodetails/1.json
  def destroy
    @avisodetail.destroy
    respond_to do |format|
      format.html { redirect_to avisodetails_url, notice: 'Avisodetail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avisodetail
      @avisodetail = Avisodetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def avisodetail_params
      params.require(:avisodetail).permit(:descrip, :comments,:category_program_id)
    end
end
