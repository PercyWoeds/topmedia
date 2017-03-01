class Contrato < ActiveRecord::Base

  validates_uniqueness_of :code

  validates_numericality_of :importe,:nrocuotas,:comision1,:comision2

  
  belongs_to :customer
  belongs_to :medio
  belongs_to :orden
  

  has_many :quotes , :dependent => :destroy
  
  accepts_nested_attributes_for :quotes, :reject_if => lambda { |a| a[:importe].blank? }, :allow_destroy => true


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

  def get_moneda
  	if self.moneda_id == 1
    	return "SOLES"
  	else
    	return  "DOLARES"
  	end

  end 



end
