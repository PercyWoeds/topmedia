class Orden < ActiveRecord::Base  	

   	validates_uniqueness_of :code 
   	validates_presence_of :marca_id, :medio_id,:producto_id, :version_id,:tiempo ,:code 
	
  	belongs_to :company
  	belongs_to :customer
  	belongs_to :user   
  	belongs_to :contrato
  	belongs_to :medio
  	belongs_to :marca
  	belongs_to :version
  	belongs_to :producto 
  	belongs_to :ciudad 
  	
  	has_many :orden_products, :dependent => :destroy

TABLE_HEADERS = ["ITEM",
			     "CONTRATO", 
			     "FECHA",
			     "MEDIO",
			     "MARCA",
			     "PRODUCTO",
			     "VERSION",
			     "TIEMPO",
			     "SUBTOTAL"]	           

TABLE_HEADERS2 = ["Nº",
                     "Programa",   
                    "01",                  
                    "02",
                    "03",             
                    "04",
                    "05",
                    "06",
                    "07",                  
                    "08",
                    "09",             
                    "10",
                    "11",
                    "12",                  
                    "13",
                    "14",             
                    "15",
                    "16",
                    "17",                  
                    "18",
                    "19",             
                    "20",
                    "21",
                    "22",
                    "23",                  
                    "24",
                    "25",             
                    "26",
                    "27",
                    "28",                  
                    "29",
                    "30",             
                    "31",   
                    "TOTAL",
                    "TARIFA  ",
                    "IMPORTE "]



  def self.search(search)
    # Title is for the above case, the OP incorrectly had 'name'
    where("code iLIKE ?", "%#{search}%")
  end



  def correlativo        
      numero = Voided.find(14).numero.to_i + 1
      lcnumero = numero.to_s
      Voided.where(:id=>'14').update_all(:numero =>lcnumero)                
  end

   def get_nro_contrato(secu_contrato)

      @numero_contrato = CustomerContrato.find_by(secu_cont: secu_contrato)

      if @numero_contrato != nil  
        if @numero_contrato.contrato.nil? 
         return "-" 
        else 
        return @numero_contrato.contrato.code 
        end 
      else
         return "-"
      end 

  end 
  
  def get_subtotal(value)
    ret  = 0
    items = OrdenProduct.where(["orden_id = ? ", self.id])
     
    if items
      
     for item in items 
     if(value == "subtotal")
        ret += item.total 
      elsif(value == "tax")
        ret += item.total*1.18 - item.total
      else         
        ret += item.total*1.18
      end
       
     end 
    end
    
    return ret
  end
  
  def get_tax(items, customer_id)
    tax = 0
    
    customer = Customer.find(customer_id)
    
    if(customer)

      if(customer.taxable == "1")

        for item   in items
          if(item and item != "")

            parts = item.split("|BRK|")
        
            id = parts[0]
           puts "item "
           puts item 
           
           total      = parts[34].to_f 
           puts "parts 0 "
           puts  parts[0] 

           puts "parts 35 "
           puts  parts[34] 

            
              product = Avisodetail.find(id.to_i)
          begin    
              if(product)
                              
                  tax += total * 0.18
                
              end
           rescue
          end 
          

          end
        end
      end
    end    
    return tax
  end
  
  
  def identifier
    return "#{self.code} - #{self.customer.name}"
  end
  def get_products    
  #  @itemproducts = OrdenProduct.find_by_sql(['Select orden_products.fecha,orden_products.price,orden_products.quantity,orden_products.tarifa,orden_products.total,avisodetails.descrip as name  from orden_products INNER JOIN avisodetails ON orden_products.avisodetail_id = avisodetails.id where orden_products.orden_id = ?', self.id ])
  @itemproducts =OrdenProduct.where(orden_id:  self.id) 
  return @itemproducts
  end
  
  def get_orden_products
    invoice_products = OrdenProduct.where(orden_id:  self.id).order(:id)    
    return invoice_products
  end
  
  def products_lines
    products = []
    invoice_products = OrdenProduct.where(orden_id:  self.id)
    
    invoice_products.each do | ip |

      ip.avisodetail[:descrip] = ip.avisodetail.descrip
      ip.avisodetail[:d01] = ip.d01
      ip.avisodetail[:d02] = ip.d02
      ip.avisodetail[:d03] = ip.d03
      ip.avisodetail[:d04] = ip.d04
      ip.avisodetail[:d05] = ip.d05
      ip.avisodetail[:d06] = ip.d06
      ip.avisodetail[:d07] = ip.d07
      ip.avisodetail[:d08] = ip.d08
      ip.avisodetail[:d09] = ip.d09
      ip.avisodetail[:d10] = ip.d10
      
      ip.avisodetail[:d11] = ip.d11
      ip.avisodetail[:d12] = ip.d12
      ip.avisodetail[:d13] = ip.d13
      ip.avisodetail[:d14] = ip.d14
      ip.avisodetail[:d15] = ip.d15
      ip.avisodetail[:d16] = ip.d16
      ip.avisodetail[:d17] = ip.d17
      ip.avisodetail[:d18] = ip.d18
      ip.avisodetail[:d19] = ip.d19
      ip.avisodetail[:d20] = ip.d20
      
      ip.avisodetail[:d21] = ip.d21
      ip.avisodetail[:d22] = ip.d22
      ip.avisodetail[:d23] = ip.d23
      ip.avisodetail[:d24] = ip.d24
      ip.avisodetail[:d25] = ip.d25
      ip.avisodetail[:d26] = ip.d26
      ip.avisodetail[:d27] = ip.d27
      ip.avisodetail[:d28] = ip.d28
      ip.avisodetail[:d29] = ip.d29
      ip.avisodetail[:d30] = ip.d30
      ip.avisodetail[:d31] = ip.d31
      
      ip.avisodetail[:tarifa] = ip.tarifa
      ip.avisodetail[:price] = ip.price 
      ip.avisodetail[:total] = ip.total 
      products.push("#{ip.avisodetail.id}|BRK|#{ip.avisodetail.d01}|BRK|#{ip.avisodetail.d02}|BRK|#{ip.avisodetail.d03}|BRK|#{ip.avisodetail.d04}|BRK|#{ip.avisodetail.d05}|BRK|#{ip.avisodetail.d06}|BRK|#{ip.avisodetail.d07}|BRK|#{ip.avisodetail.d08}|BRK|#{ip.avisodetail.d09}|BRK|#{ip.avisodetail.d10}|BRK|#{ip.avisodetail.d11}|BRK|#{ip.avisodetail.d12}|BRK|#{ip.avisodetail.d13}|BRK|#{ip.avisodetail.d14}|BRK|#{ip.avisodetail.d15}|BRK|#{ip.avisodetail.d16}|BRK|#{ip.avisodetail.d17}|BRK|#{ip.avisodetail.d18}|BRK|#{ip.avisodetail.d19}|BRK|#{ip.avisodetail.d20}|BRK|#{ip.avisodetail.d21}|BRK|#{ip.avisodetail.d22}|BRK|#{ip.avisodetail.d23}|BRK|#{ip.avisodetail.d24}|BRK|#{ip.avisodetail.d25}|BRK|#{ip.avisodetail.d26}|BRK|#{ip.avisodetail.d27}|BRK|#{ip.avisodetail.d28}|BRK|#{ip.avisodetail.d29}|BRK|#{ip.avisodetail.d30}|BRK|#{ip.avisodetail.d31}|BRK|#{ip.avisodetail.tarifa}|BRK|#{ip.avisodetail.price}|BRK|#{ip.avisodetail.total}")
    end


    return products.join(",")
  end
  
    def get_processed
    if(self.processed == "1")
      return "Aprobado "

    elsif (self.processed == "2")
      
      return "**Anulado **"

    elsif (self.processed == "3")

      return "-Cerrado --"  
    else   
      return "No procesado"
        
    end
  end
  
  def get_processed_short
    if(self.processed == "1")
      return "Si"
    elsif (self.processed == "3")
       return "Si"
    else
      return "No"
    end
  end
  
  
  def calcularTarifa(tiempo)
    items = OrdenProduct.where(["orden_id = ? ", self.id])
    
  for ip in items
        
        if tiempo.to_i > 0
          ip.price = (ip.tarifa / 30 * tiempo.to_i )  
          ip.total = ip.price * ip.quantity
          ip.save
       end 
       
    end 
     
    
  end 
  def add_digital
        detalle = OrdenProduct.new
        detalle.orden_id = self.id 
        detalle.avisodetail_id = self.avisodetail_id
        detalle.price = self.tarifa 
        detalle.quantity = 1
        detalle.total  =self.tarifa 
        detalle.tarifa = self.tarifa 
        
        a = self.fecha_inicio
        b = self.fecha_fin 
        
        
        parts0 = b.strftime("%Y-%m-%d") 
        parts = parts0.split("-")
        
        yy = parts[0]
        mm = parts[1]
        dd = parts[2].to_i 
        #dd = "d" << parts[2].to_s.rjust(2, '0')
        
        puts "dd"
        puts dd
        if dd == 1
           detalle.d01 = 1
          else
           detalle.d01 = 0   
        end
        if dd == 2
           detalle.d02 = 1
          else
           detalle.d02 = 0   
        end
        
        if dd == 3
           detalle.d03 = 1
          else
           detalle.d03 = 0   
        end
        
        if dd == 4
           detalle.d04 = 1
          else
           detalle.d04 = 0   
        end
        if dd == 5
           detalle.d05 = 1
          else
           detalle.d05 = 0   
        end
        
        if dd == 6
           detalle.d06 = 1
          else
           detalle.d06 = 0   
        end
        if dd == 7
           detalle.d07 = 1
          else
           detalle.d07 = 0   
        end
        if dd == 8
           detalle.d08 = 1
          else
           detalle.d08 = 0   
        end
        
        if dd == 9
           detalle.d09 = 1
          else
           detalle.d09 = 0   
        end
        
        if dd == 10
           detalle.d10 = 1
          else
           detalle.d10 = 0   
        end
        
        if dd == 11
           detalle.d11 = 1
          else
           detalle.d11 = 0   
        end
        
        if dd == 12
           detalle.d12 = 1
          else
           detalle.d12 = 0   
        end
        
        
        if dd == 13
           detalle.d13 = 1
          else
           detalle.d13 = 0   
        end
        
        if dd == 14
           detalle.d14 = 1
          else
           detalle.d14 = 0   
        end
        if dd == 15
           detalle.d15 = 1
          else
           detalle.d15 = 0   
        end
        
        if dd == 16
           detalle.d16 = 1
          else
           detalle.d16 = 0   
        end
        
        if dd == 17
           detalle.d17 = 1
          else
           detalle.d17 = 0   
        end
        if dd == 18
           detalle.d18 = 1
          else
           detalle.d18 = 0   
        end
        if dd == 19
           detalle.d19 = 1
          else
           detalle.d19 = 0   
        end
        
        if dd == 20
           detalle.d20 = 1
          else
           detalle.d20 = 0   
        end
        if dd == 21
           detalle.d21 = 1
          else
           detalle.d21 = 0   
        end
        if dd == 22
           detalle.d22 = 1
          else
           detalle.d22 = 0   
        end
        if dd == 23
           detalle.d23 = 1
          else
           detalle.d23 = 0   
        end
        if dd == 24
           detalle.d24 = 1
          else
           detalle.d24 = 0   
        end
        if dd == 25
           detalle.d25 = 1
          else
           detalle.d25 = 0   
        end
        if dd == 26
           detalle.d26 = 1
          else
           detalle.d26 = 0   
        end
        if dd == 27
           detalle.d27 = 1
          else
           detalle.d27 = 0   
        end
        if dd == 28
           detalle.d28 = 1
          else
           detalle.d28 = 0   
        end
        if dd == 29
           detalle.d29 = 1
          else
           detalle.d29 = 0   
        end
        if dd == 30
           detalle.d30 = 1
          else
           detalle.d30 = 0   
        end
        if dd == 31
           detalle.d31 = 1
          else
           detalle.d31 = 0   
        end
        
        
        detalle.save
        
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
  
  def get_moneda(id)
      texto = ""
      if id == 1
          texto = "DOLARES"
      else
          texto = "SOLES"
      end 
      
      return texto 
  end 
  # Process the invoice
  def process
    if(self.processed == "1" or self.processed == true)          
      self.processed="1"
      self.date_processed = Time.now
      self.save
    end
  end
  def cerrar
    if(self.processed == "3" )         
      
      self.processed="3"
      self.date_processed = Time.now
      self.save
    end
  end
  
  # Process the invoice
  def anular
    if(self.processed == "2" )          
      self.processed="2"
      self.date_processed = Time.now
      self.save
    end
  end  
  def processed_color
    if(self.processed == "1")
      return "green"
    else
      return "red"
    end
  end
 def get_sumas(value)
    
    ordens= OrdenProduct.where([" orden_id = ?  ", self.id ])
    ret = 0
    for orden in ordens
      if(value == "quantity")
        ret += orden.quantity
      else
        ret += orden.total 
      end
    end
    return ret

  end  

    def get_ordenes_detalle0(fecha1,fecha2,customer)
    
    @orden =Orden.where(["fecha >= ? and fecha <= ? and customer_id=? and medio_id=? and secu_cont =? and moneda_id=?  ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",customer,medio,secuencia,moneda ]).order(:month,:code )
    return @orden

  end 


  
  def get_ordenes_detalle(fecha1,fecha2,customer,medio,secuencia,moneda)
    
    @orden =Orden.where(["fecha >= ? and fecha <= ? and customer_id=? and medio_id=? 
      and secu_cont =? and moneda_id=? and processed = ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",customer,medio,secuencia,moneda ,"1"]).order(:month,:code )
    return @orden

  end 


  def get_abonos_detalle(fecha1,fecha2,customer,medio,secuencia,moneda)
    
    @abono =ContratoAbono.where(["fecha >= ? and fecha <= ? and customer_id=? and medio_id=? and secu_cont =? and moneda_id=?  ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",customer,medio,secuencia,moneda ]).order(:secu_cont )
    return @abono 

  end 

    def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Orden.create! row.to_hash 
        end
    end      


end
