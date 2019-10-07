class SupplierPayments::SupplierpaymentDetailsController < ApplicationController
   before_action :set_supplierpayment
   before_action :set_supplierpayment_detail, :except=> [:new,:new2,:create]
   

  # GET /supplierpayment_details
  # GET /supplierpayment_details.json
  def index
    @supplierpayment_details = SupplierpaymentDetail.all
  end

  # GET /supplierpayment_details/1
  # GET /supplierpayment_details/1.json
  def show
    
    
  end



  # GET /supplierpayment_details/new
  def new
    @supplierpayment_detail = SupplierpaymentDetail.new
    @documentos = Document.all.order(:description) 
    @suppliers = Supplier.all.order(:name) 
    @purchases= Purchase.all
    @company = Company.find(1)

    @lcSaldoCheque = 0
    @lcSaldoCheque = @supplierpayment.total - @supplierpayment_detail.sumar_total(@supplierpayment.id)
     
  end

  # GET /supplierpayment_details/new
  def new2

    @supplierpayment_detail = SupplierpaymentDetail.new
    @documentos = Document.all.order(:description) 
    @suppliers = Supplier.all.order(:name) 
    @purchases= Purchase.all
    @company = Company.find(1)


    @lcSaldoCheque = 0
    @lcSaldoCheque = @supplierpayment.total - @supplierpayment_detail.sumar_total(@supplierpayment.id)
    
     
  end

  # GET /supplierpayment_details/1/edit
  def edit
      @documentos = Document.all 
    @suppliers = Supplier.all 
    @purchases= Purchase.all 
    @company = Company.find(1)
    @ac_documento = @supplierpayment_detail.purchase_id
    
    
  end

  # POST /supplierpayment_details
  # POST /supplierpayment_details.json
  def create
    @supplierpayment_detail = SupplierpaymentDetail.new(supplierpayment_detail_params)
    @supplierpayment_detail.supplier_payment_id  = @supplierpayment.id 
   
    respond_to do |format|
      if @supplierpayment_detail.save
        format.html { redirect_to @supplierpayment, notice: 'Supplierpayment detail was successfully created.' }
        format.json { render :show, status: :created, location: @supplierpayment}
      else
        format.html { render :new }
        format.json { render json: @supplierpayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supplierpayment_details/1
  # PATCH/PUT /supplierpayment_details/1.json
  def update
    respond_to do |format|
      if @supplierpayment_detail.update(supplierpayment_detail_params)
        format.html { redirect_to @supplierpayment, notice: 'Supplierpayment detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @supplierpayment }
      else
        format.html { render :edit }
        format.json { render json: @supplierpayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supplierpayment_details/1
  # DELETE /supplierpayment_details/1.json
  def destroy
    
    @supplierpayment_detail.destroy
    
    if @supplierpayment_detail.destroy
      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @supplier_payment_detail 
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show 
    end 
  end

  private
    def set_supplierpayment 
      @supplierpayment  = SupplierPayment.find(params[:supplier_payment_id])
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_supplierpayment_detail
      @supplierpayment_detail = SupplierpaymentDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def supplierpayment_detail_params
      params.require(:supplierpayment_detail).permit(:document_id, :documento, :supplier_id, :tm, :total, :descrip, :purchase_id, :supplier_payment_id, :tipocambio, :numero_documento, :fecha_documento )
    end
end
