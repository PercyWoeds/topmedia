class Contrato < ActiveRecord::Base

  validates_uniqueness_of :code

  validates_numericality_of :importe,:nrocuotas,:comision1,:comision2

  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :orden
   has_many :facturas
  
  has_many :contrato_details, :dependent => :destroy
 

  TABLE_HEADERS = ["ITEM",
                     "NRO.",
                     "FECHA",
                     "CLIENTE",
                     "MEDIO",
                     "MONEDA",
                     "CONTRATO",
                     "NRO.CUOTA",                     
                     "COMISION 1",
                     "COMISION 2",
                     "IMPORTE"]


            


  def get_contrato

	if self.tipocontrato_id == 1
    	return "CUOTAS "
  	else
    	return  "CONTRA AVISO "
  	end

  end 	
  
  def get_contrato_cuotas(id)
      @contrato_cuotas = ContratoDetail.where(:contrato_id=>id)
      return @contrato_cuotas
  end 

  def get_moneda
  	if self.moneda_id == 1
    	return "SOLES"
  	else
    	return  "DOLARES"
  	end

  end 
def correlativo        
        numero = Voided.find(13).numero.to_i + 1
        lcnumero = numero.to_s
        Voided.where(:id=>'13').update_all(:numero =>lcnumero)        
        
  end


end
