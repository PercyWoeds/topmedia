class Contrato < ActiveRecord::Base
  validates_uniqueness_of :code

  
  
  belongs_to :customer 
  belongs_to :medio
  belongs_to :orden
  belongs_to :moneda 
  


  has_many :facturas
  
  has_many :contrato_details, :dependent => :destroy
 
  scope :by_year, lambda { |year| where('extract(year from fecha ) = ?', year) }



  validates_presence_of :code,:fecha,:customer_id,:medio_id, :moneda_id,:tipocontrato_id,:description,:codigointerno
  validates_numericality_of :importe,:nrocuotas,:comision1,:comision2,:comision3


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
                     
  TABLE_HEADERS1 = [ "NRO",
                     "CONTRATO",
                     "FECHA",
                     "CLIENTE",
                     "MEDIOS",
                     "MONEDA",
                     "TIPO",
                     "COMISION1",
                     "COMISION2",         
                     "COMISION3",         
                      "IMPORTE"]
                     
 TABLE_HEADERS2 = [ "NRO",
                     "CONTRATO",
                     "FECHA",
                     "CLIENTE",
                     "MEDIOS",
                     "MONEDA",
                     "TIPO",
                     "COMISION1",
                     "COMISION2",         
                     "COMISION3",         
                      "IMPORTE"]
  
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



    def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
      
        where("extract(year from fecha ) = ? ", "#{search}")
          
    end

    def self.search2(search2)
    # Title is for the above case, the OP incorrectly had 'name'
      
        where("code like ? ", "#{search2}")
          
    end


    def   get_medio(medio)

      a = Medio.find(medio)
      if a.nil?
        return " "
      else
        return a.descrip
      end 
      
    end 


   def   get_customer(customer)

      a= Customer.find(customer)
      if a.nil?
        return ""
      else
       return a.name 
      end

   end

     
  def get_contrato

  	if self.tipocontrato_id == 1
    	return "CUOTAS "
  	else
    	return  "CONTRA AVISO "
  	end 	
  end 

 def get_contrato_id(id)

  a = Contrato.find(id)

    if a.tipocontrato_id == 1
      return "CUOTAS "
    else
      return  "CONTRA AVISO "
    end   
  end 
def get_contratos_medio_customer_detalle(fecha1,fecha2,medio)    
    @contratos = Contrato.select("customer_id").
    where(["contratos.fecha >= ? and contratos.fecha <= ? and medio_id=? ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio]).distinct.group(:customer_id).order(:customer_id)
    return @contratos
end 


def get_contratos_medio_customer(fecha1,fecha2,medio)    
    @contratos = Contrato.select("customer_id").joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and medio_id=? 
     and contrato_details.factura1 <> ? and contrato_details.fecha_pago  is null ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,"" ]).distinct.group(:customer_id).order(:customer_id)
    return @contratos
end 



def get_contratos_medio_customer2(fecha1,fecha2,medio)    
    @contratos = Contrato.select("customer_id").joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and medio_id=? 
     and contrato_details.facturacanal  <> ? and contrato_details.factura1   = ? ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,"","" ]).distinct.group(:customer_id).order(:customer_id)
    return @contratos
end 

def get_contratos_customer_contrato_detalle(fecha1,fecha2,medio,customer)    
    @contratos = Contrato.
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contratos.medio_id=? and contratos.customer_id = ?
   ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,customer ]).distinct

    return @contratos
end 
def get_contratos_customer_contrato(fecha1,fecha2,medio,customer)    
    @contratos = Contrato.joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contratos.medio_id=? and contratos.customer_id = ?
     and contrato_details.factura1 <> ? and contrato_details.fecha_pago is null  ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,customer, "" ]).distinct

    return @contratos
end 


def get_contratos_customer_contrato20(fecha1,fecha2,medio,customer)    
    @contratos = Contrato.joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contratos.medio_id=? and contratos.customer_id = ?
     and contrato_details.facturacanal <> ? and contrato_details.factura1 = ?  ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,customer, "","" ]).distinct

    return @contratos
end 


def get_contratos_customer_contrato2(fecha1,fecha2,medio,customer)    
    @contratos = Contrato.joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contratos.medio_id=? and contratos.customer_id = ?
     and contrato_details.factura1 <> ? and contrato_details.fecha_pago is null  ", 
     "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,customer, "" ]).distinct
    return @contratos
end 


  def get_contrato_cuotas(id)
      @contrato_cuotas = ContratoDetail.where(:contrato_id=>id).order(:fecha,:nro)
      return @contrato_cuotas
  end 

  def get_contrato_cuotas_cobrar(id)
      @factura1=""
      @contrato_cuotas = ContratoDetail.where(["contrato_id = ? and factura1 <> ? and fecha_pago is null ",id, "" ]).order(:fecha,:nro)
      return @contrato_cuotas
  end 

def get_contrato_cuotas_cobrar2(id)
      @factura1=""
      @contrato_cuotas = ContratoDetail.where(["contrato_id = ? and facturacanal <> ? and factura1 = ? ",id, "","" ]).order(:fecha,:nro)
      return @contrato_cuotas
  end 



 def get_contrato_cuotas_facturar(id)
      @contrato_cuotas = ContratoDetail.where(:contrato_id=>id, factura1: nil ).order(:fecha,:nro)
      return @contrato_cuotas
  end 


  def get_moneda
  	if self.moneda_id == 2
    	return "SOLES"
  	else
    	return  "DOLARES"
  	end

  end 
  
  def get_moneda_id(moneda_id)
    if self.moneda_id == 2
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
  

  def get_mes(mes)

       case  
          when mes == 1 
              return "Enero"
          when mes == 2
            return "Febrero"
          when mes == 3
            return "Marzo"
          when mes == 4
            return "Abril"
          when mes == 5
            return "Mayo"
          when mes == 6
            return "Junio"
          when mes == 7
            return "Julio"
          when mes == 8
            return "Agosto"
          when mes == 9
            return "Setiembre"
          when mes == 10
            return  "Octubre"
          when mes == 11
            return "Noviembre"
          when mes == 12
            return "Diciembre"

       end 


  end 
  
  def get_saldo_acumulado_orden(fecha1,fecha2)
      ret =0
      ret1 =0
      @contrato = Contrato.where(['fecha <= ? and id = ? ',"#{fecha2} 23:59:59",self.id]).sum(importe)
      
      @orden = Orden.where(['fecha2<= ? and contrato_id = ? ',"#{fecha2} 23:59:59",self.id])
      
      if @orden != nil
              for factura in @orden
               @detail =  Orden.where(:orden_id => factura.id)
                  for d in @detail 
                      ret += d.total            
                  end 
                  ret += factura.total.round(2)
               end 
       else
            ret = 0
       end 

         ret1 = @contrato - ret       
        
    return ret1
      
  end 

    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Contrato.create! row.to_hash 
        end
    end      

end
