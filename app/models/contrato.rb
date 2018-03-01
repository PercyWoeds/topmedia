class Contrato < ActiveRecord::Base
  validates_uniqueness_of :code

  validates_numericality_of :importe,:nrocuotas,:comision1,:comision2,:comision3
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :orden
  belongs_to :moneda 
  
  has_many :facturas
  
  has_many :contrato_details, :dependent => :destroy
 

  TABLE_HEADERS = [ "CUOTA","VALOR VENTA",
                     "IGV.",
                     "TOTAL
                     CUOTA",
                     "FACTURA
                     CANAL",
                     "FACTURA
                     MASA",
                     "FECHA
                     CANCELA",                     
                      "SIT"]
                     

  TABLE_HEADERS3 = ["ITEM",
                     "NRO.",
                     "FECHA",
                     "CLIENTE",
                     "MEDIO",
                     "MONEDA",
                     " ",
                     "ABONOS",
                     "CARGOS",                     
                     "CARGOS ACUM",
                     "SALDO"]

            
 TABLE_HEADERS4 = ["",
                     "NRO.",
                     "FECHA",
                     "MARCA",
                     "PRODUCTO",
                     "VERSION",
                     "TIEMPO",
                     "",
                     "",                     
                     "",
                     ""]


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
  
  def get_contrato_canceladas(value)
   
   contratos= ContratoDetail.where([" contrato_id = ? and sit = '1' ", self.id ])
    ret = 0
    
    for contrato in contratos
      if(value == "vventa")
        ret += contrato.vventa
      else
        ret += contrato.importe
      end
    end
    
    return ret
   
  end 
  

end
