class CampaniaController < ApplicationController
  before_action :set_campanium, only: [:show, :edit, :update, :destroy]

  # GET /campania
  # GET /campania.json
  def index
    @campania = Campanium.all
  end

  # GET /campania/1
  # GET /campania/1.json
  def show
  end

  # GET /campania/new
  def new
    @campanium = Campanium.new
  end

  # GET /campania/1/edit
  def edit
  end

  # POST /campania
  # POST /campania.json
  def create
    @campanium = Campanium.new(campanium_params)

    respond_to do |format|
      if @campanium.save
        format.html { redirect_to @campanium, notice: 'Campanium was successfully created.' }
        format.json { render :show, status: :created, location: @campanium }
      else
        format.html { render :new }
        format.json { render json: @campanium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campania/1
  # PATCH/PUT /campania/1.json
  def update
    respond_to do |format|
      if @campanium.update(campanium_params)
        format.html { redirect_to @campanium, notice: 'Campanium was successfully updated.' }
        format.json { render :show, status: :ok, location: @campanium }
      else
        format.html { render :edit }
        format.json { render json: @campanium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campania/1
  # DELETE /campania/1.json
  def destroy
    @campanium.destroy
    respond_to do |format|
      format.html { redirect_to campania_url, notice: 'Campanium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campanium
      @campanium = Campanium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campanium_params
      params.require(:campanium).permit(:descrip, :comments)
    end
end
