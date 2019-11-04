class Conciliabank < ActiveRecord::Base


validates_presence_of :company_id, :saldo_inicial,:saldo_final,:user_id,:fecha1,:fecha2

validates_numericality_of :saldo_inicial, :saldo_final, allow_nil: false 

has_many :conciliabank_details, :dependent => :destroy



belongs_to :bank_acount 
belongs_to :moneda  

  def get_subtotal(value)
    ret  = 0
    items = ConciliabankDetail.where(["conciliabank_id = ? ", self.id])
     
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


 
   def process(fecha1,fecha2,banco)
    puts "fechas process"
     puts fecha1
     puts fecha2
     puts banco
     

      cheque  =SupplierPayment.where(["fecha1 >= ? and fecha1 <= ? and bank_acount_id =?","#{fecha1} 00:00:00", "#{fecha2} 23:59:59",banco])
      
      ConciliabankDetail.where(conciliabank_id: self.id,importado: "1").delete_all
      
      #Selecciona datos para calcular onp essalud
    
      
      for ip in cheque       
        
        a=  ConciliabankDetail.new(fecha: ip.fecha1, tipomov_id: "1", cargo: ip.total, abono: 0.0, 
          concepto:ip.descrip , nrocheque: ip.documento , conciliabank_id: self.id, importado: "1")
        a.save      

      end

           self.cargos = self.get_subtotal("cargos")
           self.abonos = self.get_subtotal("abonos")
           self.saldo_final = self.saldo_inicial - self.cargos + self.abonos
          
           self.update_attributes(:saldo_final=>self.saldo_final)
           

    end  



end
