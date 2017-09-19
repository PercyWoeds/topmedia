class Orden < ActiveRecord::Base  	

   	validates_uniqueness_of :code 
	
  	belongs_to :company
  	belongs_to :customer
  	belongs_to :user   
  	belongs_to :contrato
  	belongs_to :medio
  	belongs_to :marca
  	belongs_to :version
  	has_many :orden_products, :dependent => :destroy

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

TABLE_HEADERS2 = ["ITEM",
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
                    "TOTAL DE UND.",
                    "TARIFA UNITARIA   ",
                    "TAFIFA  ",
                    "IMPORTE "]

  def correlativo        
      numero = Voided.find(14).numero.to_i + 1
      lcnumero = numero.to_s
      Voided.where(:id=>'14').update_all(:numero =>lcnumero)                
  end

  
  
  def get_subtotal(items)
    subtotal = 0
    
    for item in items
      if(item and item != "")
        parts = item.split("|BRK|")

        id = parts[0]
      
       
        total      = parts[34].to_f

        begin
          product = Avisodetail.find(id.to_i)
          subtotal += total
        rescue
        end
      end
    end
    
    return subtotal
  end
  
  def get_tax(items, customer_id)
    tax = 0
    
    customer = Customer.find(customer_id)
    
    if(customer)

      if(customer.taxable == "1")

        for item in items
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
  
  def delete_products()
    invoice_products = OrdenProduct.where(orden_id: self.id)
    
    for ip in invoice_products
      ip.destroy
    end
  end
  
  def add_products(items)

    for item in items
      if(item and item != "")
        parts = item.split("|BRK|")
        
        id    = parts[0]
        dia_01 = parts[1]
        dia_02 = parts[2]
        dia_03 = parts[3]
        dia_04 = parts[4]
        dia_05 = parts[5]
        dia_06 = parts[6]
        dia_07 = parts[7]
        dia_08 = parts[8]
        dia_09 = parts[9]
        dia_10 = parts[10]
        dia_11 = parts[11]
        dia_12 = parts[12]
        dia_13 = parts[13]
        dia_14 = parts[14]
        dia_15 = parts[15]
        dia_16 = parts[16]
        dia_17 = parts[17]
        dia_18 = parts[18]
        dia_19 = parts[19]
        dia_20 = parts[20]
        dia_21 = parts[21]
        dia_22 = parts[22]
        dia_23 = parts[23]
        dia_24 = parts[24]
        dia_25 = parts[25]
        dia_26 = parts[26]
        dia_27 = parts[27]
        dia_28 = parts[28]
        dia_29 = parts[29]
        dia_30 = parts[30]
        dia_31 = parts[31]
        
        precio     = parts[32]        
        tarifa_1  = parts[33]
        total      = parts[34] 
        
        quantity_1 = 0  
      

       
  
          product = Avisodetail.find(id.to_i)        
          new_invoice_product = OrdenProduct.new(:orden_id => self.id, :avisodetail_id => product.id, :price => precio.to_f, :quantity => quantity_1, :tarifa => tarifa_1, :total => total.to_f,
          :d01=>dia_01.to_i,:d02=>dia_02.to_i,:d03=>dia_03.to_i,:d04=>dia_04.to_i,:d05=>dia_05.to_i,:d06=>dia_06.to_i,:d07=>dia_07.to_i,:d08=>dia_08.to_i,:d09=>dia_09.to_i, :d10=>dia_10.to_i,           
          :d11=>dia_11.to_i,:d12=>dia_12.to_i,:d13=>dia_13.to_i,:d14=>dia_14.to_i,:d15=>dia_15.to_i,:d16=>dia_16.to_i,:d17=>dia_17.to_i,:d18=>dia_18.to_i,:d19=>dia_19.to_i, :d20=>dia_20.to_i,
          :d21=>dia_21.to_i,:d22=>dia_22.to_i,:d23=>dia_23.to_i,:d24=>dia_24.to_i,:d25=>dia_25.to_i,:d26=>dia_26.to_i,:d27=>dia_27.to_i,:d28=>dia_28.to_i,:d29=>dia_29.to_i, :d30=>dia_30.to_i,:d31 => dia_31.to_i)
         
          new_invoice_product.save

    
          
  
      end
    end
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
    invoice_products = OrdenProduct.where(orden_id:  self.id)    
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

end
