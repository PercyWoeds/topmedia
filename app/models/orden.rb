class Orden < ActiveRecord::Base  	

   	validates_uniqueness_of :code 
	
  	belongs_to :company
  	belongs_to :customer
  	belongs_to :user   
  	belongs_to :contrato
  	belongs_to :medio
  	belongs_to :marca
  	belongs_to :version
  	has_many :orden_products

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
                    "TOTAL   ",
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
        quantity = parts[4]
        tarifa_1 = parts[5]

        price = tarifa_1.to_f / 30
        price = price * 10 


        total = price  * quantity.to_i
  
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
            quantity = parts[4]                       
            tarifa_1 = parts[5].to_f

        	price =   ( tarifa_1 / 30 ) * 10

        	total =  price  * quantity.to_i

            begin
              product = Avisodetail.find(id.to_i)
              
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
        dia_1 = parts[1]
        dia_2 = parts[2]
        dia_3 = parts[3]
        dia_4 = parts[4]
        dia_5 = parts[5]
        dia_6 = parts[6]
        dia_7 = parts[7]
        dia_8 = parts[8]
        dia_9 = parts[9]
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
        
       # fecha_dd   = parts[1]        
       # fecha_mm   = parts[2]        
       # fecha_aa   = parts[3]               
        
       # fecha_d = fecha_aa <<"-"<< fecha_mm <<"-"<<fecha_dd <<" 00:00:00" 

        
        tarifa_1 = parts[32].to_f

        price = ( (tarifa_1  / 30 ) * 10  )                                   

        total = price * quantity.to_i
                
        begin
          product = Avisodetail.find(id.to_i)
          
          new_invoice_product = OrdenProduct.new(:orden_id => self.id, :avisodetail_id => product.id,:fecha=>fecha_d, :price => price.to_f, :quantity => quantity.to_i, :tarifa => tarifa_1,:dia=>fecha_dd, :total => total.to_f)
          new_invoice_product.save

        rescue
          
        end
      end
    end
  end
  
  def identifier
    return "#{self.code} - #{self.customer.name}"
  end
  def get_products    
    @itemproducts = OrdenProduct.find_by_sql(['Select orden_products.fecha,orden_products.price,orden_products.quantity,orden_products.tarifa,orden_products.total,avisodetails.descrip as name  from orden_products INNER JOIN avisodetails ON orden_products.avisodetail_id = avisodetails.id where orden_products.orden_id = ?', self.id ])

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

      ip.product[:price] = ip.price
      ip.product[:quantity] = ip.quantity
      ip.product[:tarifa] = ip.tarifa
      ip.product[:total] = ip.total
      #products.push("#{ip.product.id}|BRK|#{ip.product.curr_quantity}|BRK|#{ip.product.curr_price}|BRK|#{ip.product.curr_discount}")
      products.push("#{ip.product.id}|BRK|#{ip.product.quantity}|BRK|#{ip.product.price}|BRK|#{ip.product.tarifa}")
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
