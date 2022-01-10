class Medios::MedioContactsController < ApplicationController
  before_action :set_medio 
  before_action :set_medio_contact, only: [:show, :edit, :update, :destroy]



  # GET /medio_contacts/1
  # GET /medio_contacts/1.json
  def show
  end

  # GET /medio_contacts/new
  def new
    @medio_contact = MedioContact.new
     @company = Company.find(1)

     if(params[:ajax])
      @ajax = true
      render :layout => false
    end

  end

  # GET /medio_contacts/1/edit
  def edit
  end

  # POST /medio_contacts
  # POST /medio_contacts.json
  def create
    @medio_contact = MedioContact.new(medio_contact_params)
    nroitem = 1 

    respond_to do |format|
      if @medio_contact.save
           nroitem += 1
        format.html { redirect_to @medio_contact, notice: 'Medio contact was successfully created.' }
        format.json { render :show, status: :created, location: @medio_contact }
      else
        format.html { render :new }
        format.json { render json: @medio_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medio_contacts/1
  # PATCH/PUT /medio_contacts/1.json
  def update
    respond_to do |format|
      if @medio_contact.update(medio_contact_params)
        format.html { redirect_to @medio_contact, notice: 'Medio contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @medio_contact }
      else
        format.html { render :edit }
        format.json { render json: @medio_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medio_contacts/1
  # DELETE /medio_contacts/1.json
  def destroy
    @medio_contact.destroy
    respond_to do |format|
      format.html { redirect_to medio_contacts_url, notice: 'Medio contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    def create_ajax

   if( params[:name] and params[:name] != "")
      @medio_detail  = MedioContact.new(code:"00" ,:name => params[:name], :medio_id => params[:medio_id])
      
      if @medio_detail.save

        render :text => "#{@medio_detail.id}|BRK|#{@medio_detail.medio_id}"
      else
        render :text => "error"
      end
    else
      render :text => "error_empty"
     
    end
  end


  private


    def set_medio 
      @medio  = Medio.find(params[:medio_id])
    end


    # Use callbacks to share common setup or constraints between actions.
    def set_medio_contact
      @medio_contact = MedioContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medio_contact_params
      params.require(:medio_contact).permit(:code, :name, :cargo, :telefono1, :telefono2, :telefono3, :anexo1, :anexo2,
       :anexo3, :celular1, :celular2, :celular3, :correo1, :correo2,:medio_id )
    end
end
