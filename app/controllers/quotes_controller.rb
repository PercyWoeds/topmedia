class QuotesController < ApplicationController

before_action :find_quote

def new
    

  @quote = Quote.new 


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

private


  
def quote_params 
  params.require(:quote).permit(:nro,:fecha,:importe,:vventa,:comision1,:comision2,:total,:facturacanal,:factura1,:factura2,:contrato_id)
end   

def find_quote
  @contrato = Contrato.find(params[:contrato_id])
end   

end



