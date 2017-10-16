class FacturaDetail < ActiveRecord::Base
    belongs_to :factura 
    
    belongs_to :contrato_detail
   
    
    end
