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

#item_line = item_id + "|BRK|"+fecha_dd + "|BRK|" + fecha_mm + "|BRK|" +fecha_yy + "|BRK|" + quantity + "|BRK|" + tarifa ;                     
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
        
        id = parts[0]
        fecha_dd   = parts[1]        
        fecha_mm   = parts[2]        
        fecha_aa   = parts[3]               
        
        fecha_d = fecha_aa <<"-"<< fecha_mm <<"-"<<fecha_dd <<" 00:00:00" 



        quantity = parts[4]
        tarifa_1 = parts[5].to_f

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
