class Medios::MedioDetailsController < ApplicationController
  before_action :set_medio 
  
  before_action :set_medio_detail, only: [:show, :edit, :update, :destroy ]

  # GET /medio_details/1
  # GET /medio_details/1.json
  def show
  end

  # GET /medio_details/new
  def new
    @medio_detail = MedioDetail.new    

    @company = Company.find(1)

     if(params[:ajax])
      @ajax = true
      render :layout => false
    end

  end

  # GET /medio_details/1/edit
  def edit
  end

  # POST /medio_details
  # POST /medio_details.json
  def create
    @medio_detail = MedioDetail.new(medio_detail_params)
    nroitem = 1 

    respond_to do |format|
      if @medio_detail.save

          nroitem += 1
          puts "nro "
          puts nroitem 


        format.html { redirect_to @medio_detail, notice: 'Medio detail was successfully created.' }
        format.json { render :show, status: :created, location: @medio_detail }
      else
        format.html { render :new }
        format.json { render json: @medio_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medio_details/1
  # PATCH/PUT /medio_details/1.json
  def update
    respond_to do |format|
      if @medio_detail.update(medio_detail_params)
        format.html { redirect_to @medio_detail, notice: 'Medio detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @medio_detail }
      else
        format.html { render :edit }
        format.json { render json: @medio_detail.errors, status: :unprocessable_entity }
      end
    end
  end

   def create_ajax

   if( params[:name] and params[:name] != "")
      @medio_detail  = MedioDetail.new(code:"00" ,:name => params[:name],user_id: current_user.id  , :medio_id => params[:medio_id])
      puts "medioo"
      puts params[:medio_id]
      puts current_user.id 
      

      if @medio_detail.save

        render :text => "#{@medio_detail.id}|BRK|#{@medio_detail.medio_id}"
      else
        render :text => "error"
      end
    else
      render :text => "error_empty"
     
    end
  end



  # DELETE /medio_details/1
  # DELETE /medio_details/1.json
  def destroy
    @medio_detail.destroy
    respond_to do |format|
      format.html { redirect_to medio_details_url, notice: 'Medio detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_medio 
      @medio  = Medio.find(params[:medio_id])
    end

    def set_medio_detail
      @medio_detail = MedioDetail.find(params[:id])
    end 



    # Never trust parameters from the scary internet, only allow the white list through.
    def medio_detail_params
      params.require(:medio_detail).permit(:code, :name, :user_id, :medio_id)
    end
end
