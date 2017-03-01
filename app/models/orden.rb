class Orden < ActiveRecord::Base

   	
   	validates_uniqueness_of :code 
	validates_numericality_of :tiempo
  	
  
  
	belongs_to :contrato
	belongs_to :medio
	belongs_to :marca
	belongs_to :version


TABLE_HEADERS = ["ITEM",
			     "CONTRATO",
			     "FECHA",
			     "",
			     "MEDIO",
			     "MARCA",
			     "VERSION",
			     "TIEMPO",
			     "FECHA1",
			     "FECHA2"]	           


end
