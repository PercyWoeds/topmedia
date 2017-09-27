class QuotesController < ApplicationController
 before_action :find_quote , only: [:new, :edit, :update,:show ,:create]
def new
  a = @contrato
  $lcCliente = a.customer.name 
  $lcMedio = a.medio.descrip 
  $lcComision1 = a.comision1
  $lcComision2 = a.comision2
  $lcTipoContrato = a.tipocontrato_id 
  $lcNrocuotas = a.nrocuotas
  $lcImporte  = a.importe 
  @quote = Quote.new 

end

def edit
  @quote = Quote.find(params[:id])
  a = @contrato
  $lcCliente = a.customer.name 
  $lcMedio = a.medio.descrip 
  $lcComision1 = a.comision1
  $lcComision2 = a.comision2
  $lcTipoContrato = a.tipocontrato_id 
  $lcNrocuotas = a.nrocuotas
  $lcImporte  = a.importe 
  
  
end 

def create

  @quote  =Quote.new(quote_params)
  @quote.contrato_id =@contrato.id

  if @quote.save
    redirect_to contrato_path(@contrato)  
  else
    render 'new'  

  end 

end

 def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote , notice: 'Concept was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  # DELETE /contratos/1
  # DELETE /contratos/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Cuota was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
private


  
def quote_params 
  params.require(:quote).permit(:nro,:fecha,:importe,:vventa,:comision1,:comision2,:total,:facturacanal,:factura1,:factura2,:contrato_id)
end   

def find_quote
  
  @contrato = Contrato.find(params[:contrato_id])
end   

end



