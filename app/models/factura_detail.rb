class FacturaDetail < ActiveRecord::Base
    belongs_to :factura 
    belongs_to :service 
    
    belongs_to :orden 
    belongs_to :medio 

    belongs_to :contrato_detail


   def get_factura(factura )

        if  Factura.where(id: factura).exists?

                a = Factura.where(id: factura )
        
                return a.first.code
        else
                return ""

        end 
    end 

 


end
