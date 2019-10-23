class Stamentacount < ActiveRecord::Base


  
validates_presence_of :company_id, :saldo_inicial,:saldo_final,:user_id,:fecha1,:fecha2


validates_numericality_of :saldo_inicial, :saldo_final, allow_nil: false 

has_many :stamentacount_details, :dependent => :destroy

belongs_to :bank_acount 


 
  def get_subtotal(value)
    ret  = 0
    items = StamentacountDetail.where(["stamentacount_id = ? ", self.id])
     
    if items
      
     for item in items 
      if(value == "cargos")
        ret += item.cargo
      else 
        ret += item.abono 
      end
       
     end 
    end
    
    return ret
  end

end

