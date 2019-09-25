class SupplierpaymentDetail < ActiveRecord::Base
    belongs_to :supplier_payment
    belongs_to :document 
    belongs_to :supplier 
    belongs_to :purchase 
    
    
    def sumar_total(id) 
        
        facturas = SupplierpaymentDetail.where(["supplier_payment_id = ? ", id ])
        if facturas
        ret=0  
        for factura in facturas
          
           ret += factura.total.round(2)
         
        end
        end 
    
        return ret
    end 
    
    def get_document(id)
        a = Document.find(id)
        return a.description 
    end 
  

end
