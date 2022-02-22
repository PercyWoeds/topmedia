class Company < ActiveRecord::Base
  validates_presence_of :user_id, :name
  
  belongs_to :user

  
  has_many :locations
  has_many :suppliers
  has_many :products
  has_many :products_kits
  has_many :restocks
  has_many :divisions
  has_many :customers
  has_many :invoices
  has_many :inventories
  has_many :company_users


  def to_hash
    hash=[]

    instance_variables_each{ |var| hash[var.to_s.delete('@')]= instance_variables_get(var)}
    hash
  end
  
  def actualiza_monthyear
    @factura = Factura.where(:year_mounth=> nil)
    for factura in @factura
        f = Factura.find(factura.id)
      if f
        @fechas =f.fecha2.to_s
        parts = @fechas.split("-")
        year = parts[0]
        mes  = parts[1]
        dia  = parts[2]      
        f.year_mounth = year+mes 
        f.save
      end 
    end 
  end 

  def actualiza_purchase_monthyear
    @factura = Factura.where(:year_mounth=> nil)
    for factura in @factura
        f = Factura.find(factura.id)
      if f
        @fechas =f.fecha2.to_s
        parts = @fechas.split("-")
        year = parts[0]
        mes  = parts[1]
        dia  = parts[2]      
        f.year_mounth = year+mes 
        f.save
      end 
    end 
  end 


  def own(user)
    if(self.user_id == user.id)
      return true
    end
  end
  
  def can_view(user)
    if(self.own(user))
      return true
    else
      company_user = CompanyUser.where(company_id:  self.id, user_id:  user.id)
      
      if(company_user)
        return true
      end
    end
  end
  def get_banks()
     banks = Bank.all      
    return banks
  end
  

  def get_bank_acounts()
     bank_acounts = BankAcount.all      
    return bank_acounts
  end
  def get_bank_acount_by(id)
     bank_acounts = BankAcount.where("id = ?", id )
    return bank_acounts
  end
  def get_productos()
     productos = Producto.all.order(:name)      
    return productos
  end
  
  def get_marcas()
     marcas = Marca.all.order(:name)  
    return marcas
  end
  def get_versions()
     versions = Version.all.order(:descrip) 
    return versions
  end
  def get_ciudads()
     ciudad = Ciudad.all      
    return ciudad 
  end
  
  def get_modelos()
     modelos = Modelo.all      
    return modelos
  end

  def get_instruccions()
     instruccions = Instruccion.all      
    return instruccions
  end

  def get_tipoordens()
     documents = TipoOrden.all 
    return documents
  end
  def get_documents()
     documents = Document.where(company_id: self.id)
    return documents
  end
  
  def get_documents_cheque()
     documents = Document.where("company_id = ? and  tipo = ? ",self.id , "H")
    return documents
  end

  def get_monedas()
     monedas = Moneda.where(company_id: self.id).order(:description)
       
    return monedas
  end

  def get_medios()
     medios = Medio.order(:descrip)
       
    return medios
  end


  def get_transports()
     transports = Tranportorder.where(company_id: self.id).order(:code)
       
    return transports
  end
  
  
  def get_suppliers()
     suppliers = Supplier.where(company_id: self.id).order(:name)
       
    return suppliers
  end
  
  def get_locations()

    locations = Location.where(company_id: self.id).order("name ASC")
    
    return locations
  end
  
  def get_divisions()
    divisions = Division.where(company_id:  self.id).order("name ASC")
    
    return divisions
  end
  def get_payments()
    payments = Payment.where(company_id:  self.id).order("descrip ASC")    
    
    return payments
  end
  def get_services()
     services = Service.where(company_id: self.id).order(:name)
     return services
  end
  def get_tipofacturas()
     tipos = Tipofactura.where(company_id: self.id).order(:descrip)
       
    return tipos
  end
  

  def get_addresses()
     addresses = Address.find_by_sql(['Select id,full_address as address from addresses' ]) 
     return addresses
  end
  
  def get_trucks()
     trucks = Truck.all.order('placa') 
     return trucks
  end
  
  def get_employees()
     employees =  Employee.find_by_sql(['Select id,licencia,full_name   from employees' ])
     return employees
  end
      
  def get_empsubs()
     empsubs = Subcontrat.all 
     return empsubs
  end 

  def get_unidads()
     unidads = Unidad.all.order(:id)
     return unidads
  end 
  
  def get_puntos()
    puntos = Punto.all 
    return puntos
  end

  def get_servicebuys()
     servicebuys = Servicebuy.all.order(:id)
     return servicebuys
  end 

  def get_categories()
     category = ProductsCategory.all.order(:category)
     return category
  end 

  def get_cliente_name(id)
     cliente = Customer.find(id)
     return cliente.name 
  end 
def get_medio_name(id)
     medio = Medio.find(id) 
     return medio.descrip 
  end 

  def get_categoria_name(id)
     category = ProductsCategory.find(id)
     return category.category
  end 
  
  def get_last_tax_name(tax_number)
    product = Product.where(company_id: self.id)
    
    if(product.any?)
      if(tax_number == 1)
        return product[0].tax1_name
      elsif(tax_number == 2)
        return product[0].tax2_name
      else
        return product[0].tax3_name
      end
    end
  end
  
  def get_last_tax(tax_number)
    product = Product.where(company_id: self.id)

    if(product.any?)
      if(tax_number == 1)
        return product[0].tax1
      elsif(tax_number == 2)
        return product[0].tax2
      else
        return product[0].tax3
      end
    end
  end
  
  def delete_logo()
    begin
      deleteFile("public#{self.logo}")
    rescue
      # nothing
    end
    
    begin
      deleteFile(img_name_size("public#{self.logo}", 200))
    rescue
      # nothing
    end
    
    begin
      deleteFile(img_name_size("public#{self.logo}", 100))
    rescue
      # nothing
    end
  end
  
  def upload_logo(file)
    require 'digest/md5'
    
    # Delete previous logo
    if(self.logo != "")
      self.delete_logo()
    end
    
    dir = "public/uploads/companies/#{self.user_id}/"
    makedir(dir)
	
  	name = file.original_filename
	
  	new_name = Digest::MD5.hexdigest(Time.now.to_s)
  	ext = getFileExt(name)
	
  	new_name = "#{new_name}_300.#{ext}"
	
  	path = File.join(dir, new_name)
	
  	File.open(path, "wb") { |f| 
  		f.write(file.read)
  	}
	
  	# Quitamos parte de public para el path
  	path_arr = path.split('/')
  	path_arr.delete_at(0)
  	path = '/' + path_arr.join('/')
    
    resizeImage(path, 300)
    
    copy_file("public#{path}", img_name_size("public#{path}", 200))
    resizeImage(img_name_size(path, 200), 200)
    
    copy_file("public#{path}", img_name_size("public#{path}", 100))
    resizeImage(img_name_size(path, 100), 100)
    
    self.logo = path
    self.save
    
    return path
  end
  
  # Get subtotal made from invoices in a date
  def get_invoices_value_date(date, value)
    date_arr = date.split("-")
    year = date_arr[0]
    month = date_arr[1]
    
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ? AND processed = '1'", self.id, "#{date} 00:00:00", "#{year}-#{month}-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Get subtotal made from invoices in an exact date
  def get_invoices_value_exact_date(date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ? AND processed = '1'", self.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end

  # Get subtotal made from invoices in a date
  def get_invoices_value_date(date, value)
    date_arr = date.split("-")
    year = date_arr[0]
    month = date_arr[1]
    
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ? AND processed = '1'", self.id, "#{date} 00:00:00", "#{year}-#{month}-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  
  def get_users()
    owner = self.user
    users = []
    users.push(owner)
    
    #company_users = CompanyUser.where(:company_id => self.id)
    
    users1 = CompanyUser.find_by(company_id:  self.id)

    @user_id =users1.user_id
    users =User.where(:id => @user_id)

    users = users.map {|s| [s.username, s.id]}
    users_f = [["", nil]]
    users_f += users
    users = users_f    

    return users
  end
 def get_guias_year(year)
    @delivery = Delivery.where(["fecha1>= ? AND fecha1 <= ? and company_id  = ? ", "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59", self.id])   
    return @delivery
 end

 def get_guias_year_month(year,month)
    @delivery = Delivery.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{year}-#{month}-01 00:00:00", "#{year}-#{month}-31 23:59:59"])
    return @delivery
 end 
 #orden de transporte
 def get_ordertransporte_day(fecha1,fecha2)
    @orden = Tranportorder.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"]).order(:code)
    return @orden 
 end 
def get_guias_day(fecha1,fecha2)
    @delivery = Delivery.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"]).order(:code)
    return @delivery
 end 

def get_guias_2(fecha1,fecha2)
    @delivery = Delivery.where(["processed<> '4' and  processed <> '2' and company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"]).order(:code)
    return @delivery
 end 

 def get_guias_3(fecha1,fecha2)
    @delivery = Delivery.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ? ", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"])
    return @delivery
 end 

 def get_guias_4(fecha1,fecha2)
    @delivery = Delivery.where(["company_id = ? AND created_at >= ? AND created_at <= ? ", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"]).order('created_at')
    return @delivery
 end 

 def get_services_year_month(year,month)
    @serviceorder = Serviceorder.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{year}-#{month}-01 00:00:00", "#{year}-#{month}-31 23:59:59"])
    return @serviceorder
 end 
 def get_services_day(fecha1,fecha2)
    @serviceorder = Serviceorder.where(["company_id = ? AND fecha1 >= ? AND fecha1 <= ?", self.id, "#{fecha1} 00:00:00", "#{fecha2} 23:59:59"])
    return @serviceorder
 end 

## generar archivo txt
 def get_facturas_year_month_day(fecha1)
    @facturas = Factura.where(["company_id = ? AND fecha >= ? and fecha<= ?", self.id, "#{fecha1} 00:00:00","#{fecha1} 23:59:59"])
    return @facturas    
 end 

 ## generar archivo concar
 def get_facturas_year_month_day2(fecha1,fecha2)
    @facturas = Factura.where(["company_id = ? AND fecha >= ? and fecha<= ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"])
    return @facturas    
 end 


## ESTADO DE CUENTA 
 def get_facturas_day(fecha1,fecha2,moneda)

    @facturas = Factura.where([" company_id = ? AND fecha >= ? and fecha<= ? and moneda_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",moneda ]).order(:id )
    return @facturas
    
 end 
 
 def get_facturas_day_value(fecha1,fecha2,value = "total",moneda)

    facturas = Factura.where([" company_id = ? AND fecha >= ? and fecha<= ? and moneda_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",moneda])
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total
      end
    end
    end 

    return ret
  
 end 
def get_facturas_day_value_cliente(fecha1,fecha2,cliente,value = "total",moneda)

    facturas = Factura.where([" company_id = ? AND fecha >= ? and fecha<= ? and customer_id = ? and moneda_id  = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",cliente,moneda ])
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total
      end
    end
    end 

    return ret
  
 end 

## REPORTES DE LIQUIDACION  DE COBRANZA

 def get_customer_payments0(fecha1,fecha2)

    @facturas = CustomerPayment.where([" company_id = ? AND fecha1 >= ? and fecha1<= ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:id)
    return @facturas
    
 end 

 def get_customer_payments_value(fecha1,fecha2,id)

    facturas = CustomerPayment.where([" company_id = ? AND fecha1 >= ? and fecha1 <= ? and bank_acount_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" , id]).order(:id)

    


    ret = 0 
    if facturas 
    ret=0  
      for factura in facturas      

          ret += factura.total

      end
    end 
    return ret    
 end 
 #total banco x cliente
def get_customer_payments_value_customer(fecha1,fecha2,id,cliente,value)
facturas = CustomerPayment.find_by_sql(['Select customer_payments.id,customer_payments.total,
facturas.code,facturas.customer_id,facturas.fecha,customer_payment_details.factory from customer_payment_details   
INNER JOIN facturas ON   customer_payment_details.factura_id = facturas.id
INNER JOIN customer_payments ON customer_payments.id = customer_payment_details.customer_payment_id    
WHERE customer_payments.fecha1 >= ? and customer_payments.fecha1 <= ?  and customer_payments.bank_acount_id = ?  and facturas.customer_id = ?',
 "#{fecha1} 00:00:00","#{fecha2} 23:59:59",id,cliente ])
    ret = 0     

    if facturas 
    ret=0  
      for d in facturas                    
            if (value == "total")
              ret += d.total    
            
            end
      end       
    end     
    return ret    
 end 

def get_customer_payments_value_otros_customer(fecha1,fecha2,value,cliente)

  facturas = CustomerPayment.find_by_sql(['Select customer_payments.id,customer_payment_details.total,
facturas.code,facturas.customer_id,facturas.fecha,customer_payment_details.factory from customer_payment_details   
INNER JOIN facturas ON   customer_payment_details.factura_id = facturas.id
INNER JOIN customer_payments ON customer_payments.id = customer_payment_details.customer_payment_id    
WHERE customer_payments.fecha1 >= ? and customer_payments.fecha1 <= ? and facturas.customer_id = ?', "#{fecha1} 00:00:00",
"#{fecha2} 23:59:59",cliente ])

    ret = 0 


    if facturas 
    ret=0  

      for factura in facturas      
                
          @detail = CustomerPaymentDetail.where(:customer_payment_id => factura.id)

          for d in @detail 
            if(value == "ajuste")
              ret += d.ajuste
            elsif (value == "compen")
              ret += d.compen 
            elsif (value == "total")
              ret += d.compen   
            else         
              ret += d.factory
            end
          end 

      end
    end 
    
    return ret    
 end 
 
 def get_customer_payments_cliente(fecha1,fecha2,cliente)

@facturas =CustomerPayment.find_by_sql(['Select customer_payments.id,customer_payment_details.total,
customer_payments as code_liq,facturas.code,facturas.customer_id,facturas.fecha,customer_payment_details.factory,
customer_payments.fecha1 
from customer_payment_details   
INNER JOIN facturas ON   customer_payment_details.factura_id = facturas.id
INNER JOIN customer_payments ON customer_payments.id = customer_payment_details.customer_payment_id    
WHERE customer_payments.fecha1 >= ? and customer_payments.fecha1 <= ? and facturas.customer_id = ?', "#{fecha1} 00:00:00",
"#{fecha2} 23:59:59",cliente ])
    
    return @facturas
    
 end 

 def get_customer_contratos

    @contratos =CustomerContrato.find_by_sql(["Select customer_contratos.secu_cont,
    concat(customer_contratos.secu_cont,' ',customers.name,'  ',medios.descrip,'  ',contratos.code) as name 
    from customer_contratos  
    INNER JOIN customers ON customer_contratos.customer_id = customers.id
    INNER JOIN medios    ON customer_contratos.medio_id = medios.id    
    INNER JOIN contratos ON customer_contratos.contrato_id = contratos.id 
    ORDER BY customers.name,medios.descrip,customer_contratos.secu_cont"])
    
    return @contratos
    
 end 

 def get_customer_payments_value_otros(fecha1,fecha2,value='factory')

    facturas = CustomerPayment.where(["fecha1 >= ? and fecha1 <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])        
        ret=0  
        for factura in facturas

          @detail = CustomerPaymentDetail.where(:customer_payment_id => factura.id)

          for d in @detail 
            if(value == "ajuste")
              ret += d.ajuste
            elsif (value == "compen")
              ret += d.compen 
            else         
              ret += d.factory
            end
          end 

        end    

    return ret
 end 


## REPORTE DE ESTADISTICAS DE PAGOS pivot

def get_customer_payments2(moneda,fecha1,fecha2)

   @facturas = Factura.find_by_sql(["
  SELECT   year_mounth as year_month,
   customer_id,
   SUM(balance) as balance   
   FROM facturas
   WHERE moneda_id = ? and balance>0 and fecha >= ? and fecha  <= ?
   GROUP BY 2,1
   ORDER BY 2,1 ", moneda,fecha1,fecha2 ])    

  return @facturas
    
 end 

 def get_customer_payments_value2(fecha1,fecha2)

 #   facturas = Factura.find_by_sql("Select customer_id,month(fecha2) as mes,year(fecha2) as anio from facturas group by month(fecha2),year(fecha2)")
    ret = 0 
    if facturas 
    ret=0  
      for factura in facturas      

          ret += factura.total

      end
    end 
    return ret    
 end 



def get_customer_payments_detail_value(fecha1,fecha2,value="total")

    facturas = CustomerPaymentDetail.where([" fecha1 >= ? and fecha1 <= ?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:id)

    if facturas
    ret=0  
    for factura in facturas      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "factory")
        ret += factura.factory.round(2)
      else         
        ret += factura.total.round(2)
      end
    end
    end 

    return ret
   
    
 end 
def actualizar_fecha2

    facturas = Factura.where(:fecha2 => nil )

    for factura in facturas
        fact =  Factura.find(factura.id)
        days = fact.payment.day 
        fechas2 = factura.fecha + days.days           
        fact.update_attributes(:fecha2=>fechas2)   
    end 

  end
#reporte de cancelaciones detallado x proveedor

def get_supplier_payments0(fecha1,fecha2)
    @vouchers = SupplierPayment.where([" company_id = ? AND fecha1 >= ? and fecha1<= ?  ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).order(:id)
    return @vouchers    
end 
  
def get_paymentsD_day_value(fecha1,fecha2,value = "total")

    facturas = SupplierPayment.where(["company_id = ? AND fecha1 >= ? and fecha1<= ?  ", 
      self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
    ret = 0
      for factura in facturas      
                
          @detail = SupplierpaymentDetail.where(:supplier_payment_id => factura.id)

          for d in @detail 
            if(value == "ajuste")
              ret += d.ajuste
            elsif (value == "compen")
              ret += d.compen 
            else
              ret += d.total            
            end
          end 

      end

      return ret
 end 

 def get_paymentsC_day_value(fecha1,fecha2,value = "total")
    ret = 0
    facturas = SupplierPayment.where(["company_id = ? AND fecha1 >= ? and fecha1<= ? ",
     self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])

      for d in facturas                
            if(value == "ajuste")
              ret += d.ajuste
            elsif (value == "compen")
              ret += d.compen 
            else
              ret += d.total            
            end          
      end

      return ret
 end 


def get_payments_detail_value(fecha1,fecha2,value = "total",moneda)

    facturas = SupplierPayment.where(["company_id = ? AND fecha >= ? and fecha<= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).order(:customer_id,:moneda_id)

    if facturas
    ret=0  
    
    for factura in facturas      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total.round(2)
      end
    end
    end 

    return ret    
 end 



 ## Pendientes 

 def get_pendientes_day(fecha1,fecha2)

    @facturas = Factura.where(["balance > 0  and  company_id = ? AND fecha >= ? and fecha<= ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:medio_id,:moneda_id,:fecha)
    return @facturas
    
 end 
 
 def get_pendientes_day_cliente1(fecha1,fecha2)

    @facturas = Factura.select("medio_id").where([" balance <> 0  and  company_id = ? AND fecha >= ? and fecha<= ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).group(:medio_id)
    #@notas = Factura.where([" balance < 0 and document_id = ?  and  company_id = ? AND fecha >= ? and fecha<= ?", "2",self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:customer_id,:moneda_id,:fecha)
    return @facturas  
    
 end 

 def get_pendientes_day_cliente2(fecha1,fecha2,customer)

    @facturas = Factura.where([" balance <> 0  and  company_id = ? AND fecha >= ? and fecha<= ? and medio_id =? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",customer]).order(:medio_id,:moneda_id,:fecha)
    #@notas = Factura.where([" balance < 0 and document_id = ?  and  company_id = ? AND fecha >= ? and fecha<= ?", "2",self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:customer_id,:moneda_id,:fecha)
    return @facturas  
    
 end 
def get_pendientes_day_cliente3(fecha1,fecha2,customer )

    @facturas = Factura.select("medio_id").where([" balance <> 0  and  company_id = ? AND fecha >= ? and fecha<= ? and medio_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",customer ]).group(:medio_id)
    #@notas = Factura.where([" balance < 0 and document_id = ?  and  company_id = ? AND fecha >= ? and fecha<= ?", "2",self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:customer_id,:moneda_id,:fecha)
    return @facturas  
    
 end 
 def get_pendientes_day_value(fecha1,fecha2,value = "balance",moneda)

    facturas = Factura.where(["balance>0  and  company_id = ? AND fecha >= ? and fecha<= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).order(:medio_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.balance.round(2)
      end
    end
    end 

    return ret    
 end 

 def get_facturas_day_cliente(fecha1,fecha2,cliente)

    @facturas = Factura.where(["total> 0  and  company_id = ? AND fecha >= ? and fecha<= ? and customer_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", cliente ]).order(:customer_id,:moneda_id,:fecha)
    return @facturas
    
 end 
 

 def get_pendientes_day_cliente(fecha1,fecha2,cliente)

    @facturas = Factura.where(["balance > 0  and  company_id = ? AND fecha >= ? and fecha<= ? and customer_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", cliente ]).order(:customer_id,:moneda_id,:fecha)
    return @facturas
    
 end 
 
 def get_pendientes_day_cliente_value(fecha1,fecha2,value = "total",moneda,cliente)

    facturas = Factura.where(["balance>0  and  company_id = ? AND fecha >= ? and fecha<= ? and moneda_id = ? and customer_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda , cliente ]).order(:customer_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total.round(2)
      end
    end
    end 

    return ret
    
 end 
 
 def get_pendientes_day_customer(fecha1,fecha2,value,moneda)

    facturas = Factura.where(["balance>0  and  company_id = ? AND fecha >= ? and fecha<= ? AND medio_id = ? and moneda_id =  ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", value , moneda ]).order(:medio_id,:moneda_id)

    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.balance.round(2)
      end
    end
    end 

    return ret    
 end 

 def get_services_day2( fecha1,fecha2, value = "total")
  
    services = Serviceorder.where([" company_id = ?  AND fecha1 >= ? AND fecha1 <= ?", self.id,"#{fecha1} 00:00:00", "#{fecha2} 23:59:59"]).order("id desc")
    ret = 0
    
    for service in services
      puts service.code 

      if(value == "subtotal")
        ret += service.subtotal
      elsif(value == "tax")
        ret += service.tax
      elsif(value == "detraccion")
      ret += service.detraccion
      else 
        
        ret += service.total
      end
    end
    
    return ret
  end
 # Return value 

 # Return value for user
 def get_services_year_month_value( year,month, value = "total")
  
    services = Serviceorder.where([" company_id = ?  AND fecha1 >= ? AND fecha1 <= ?", self.id,"#{year}-#{month}-01 00:00:00", "#{year}-#{month}-31 23:59:59"]).order("id desc")
    ret = 0
    
    for service in services
      puts service.code 

      if(value == "subtotal")
        ret += service.subtotal
      elsif(value == "tax")
        ret += service.tax
      elsif(value == "detraccion")
      ret += service.detraccion
      else 
        
        ret += service.total
      end
    end
    
    return ret
  end
 # Return value 
 def get_purchases_year_month_value( year,month, value = "total_amount")
  
    purchases = Purchase.where(["purchases.balance > 0  and  company_id = ?  AND date2 >= ? AND date2 <= ?", self.id,"2000-01-01 00:00:00", "#{year}-#{month}-31 23:59:59"]).order("id desc")
    ret = 0
    
    for purchase in purchases
      
      if(value == "subtotal")
        ret += purchase.subtotal
      elsif(value == "tax")
        ret += purchase.tax
      else
        ret += purchase.total_amount
      end
    end
    
    return ret
  end

  def get_purchases_year_month( year,month)
  
    @purchases = Purchase.where(["purchases.balance > 0  and  company_id = ?  AND date2 >= ? AND date2 <= ?", self.id,"2000-01-01 00:00:00", "#{year}-#{month}-31 23:59:59"]).order("supplier_id")  
    
    return @purchases 
  end
  def get_purchases_day(fecha1,fecha2)
  
    @purchases = Purchase.where([" company_id = ? AND date1 >= ? and date1 <= ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",  ]).order(:supplier_id,:moneda_id,:date1)    
    return @purchases 
  end


  def get_purchases_by_day(fecha1,fecha2,moneda)
  
    @purchases = Purchase.where([" company_id = ? AND date1 >= ? and date1 <= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda , ]).order(:id,:moneda_id)    
    return @purchases 
  end

  def get_purchases_by_day2(fecha1,fecha2,moneda)
  
    @purchases = Purchase.select("document_id").where([" company_id = ? AND fecha3 >= ? and fecha3 <= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).group(:document_id)
  

    return @purchases 
  end


  def get_purchases_by_moneda_doc(fecha1,fecha2,moneda,documento)  
    @purchases = Purchase.where([" company_id = ? AND fecha3 >= ? and fecha3 <= ? and moneda_id = ? and document_id=? ", self.id, "#{fecha1}","#{fecha2}", moneda , documento ]).order(:document_id,:date1)    
    return @purchases 
  end


  def get_purchases_by_day_detalle(fecha1,fecha2)
    @purchases = Purchase.where([" company_id = ? AND fecha3 >= ? and fecha3 <= ?  ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:moneda_id,:document_id)
    return @purchases 
  end


  def get_purchases_by_day_value(fecha1,fecha2,moneda,value='total_amount')
  
    purchases = Purchase.where([" company_id = ? AND date1 >= ? and date1 <= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).order(:moneda_id,:document_id)    

    ret = 0
    for purchase in purchases
      

      if(value == "payable_amount")
        ret += purchase.payable_amount
      elsif(value == "tax_amount")
        ret += purchase.tax_amount
      elsif(value == "inafecto")
        ret += purchase.inafecto 
       
      else
        ret += purchase.total_amount
      end
    end
    
    return ret


  end
  
  def get_purchases_by_doc_value(fecha1,fecha2,moneda,doc,value='total_amount')
  
    purchases = Purchase.where([" company_id = ? AND date1 >= ? and date1 <= ? and moneda_id  =?   and document_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",moneda, doc ]).order(:moneda_id,:document_id)    

    ret = 0
    for purchase in purchases
      if(value == "inafecto")
        ret += purchase.inafecto
      elsif(value == "payable_amount")
        ret += purchase.payable_amount
      elsif(value == "tax_amount")
        ret += purchase.tax_amount
      else
        ret += purchase.total_amount
      end
    end
    
    return ret


  end
  
  
  
 def get_purchases_by_day_value_supplier(fecha1,fecha2,moneda,value='total_amount',supplier)
  
    purchases = Purchase.where([" company_id = ? AND date1 >= ? and date1 <= ? and moneda_id = ? and supplier_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda , supplier ]).order(:id,:moneda_id)    

    ret = 0
    for purchase in purchases
      
      if(value == "subtotal")
        ret += purchase.subtotal
      elsif(value == "tax")
        ret += purchase.tax
      else
        ret += purchase.total_amount
      end
    end
    
    return ret

  end 

 def get_purchase_day_value2(fecha1,fecha2,supplier,moneda,value="total")

    facturas = Purchase.where(["company_id = ? AND date1 >= ? and date1<= ? and supplier_id = ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",supplier, moneda ]).order(:supplier_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total_amount.round(2)
      end
    end
    end 

    return ret
    
 end 

 def get_purchases_pendientes_day(fecha1,fecha2)

    @facturas = Purchase.where(["balance > 0  and  company_id = ? AND date1 >= ? and date1<= ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59"]).order(:supplier_id,:moneda_id,:date1)
    return @facturas
    
 end 

 def get_purchases_pendientes_day_supplier_1(fecha1,fecha2,cliente)
    @facturas = Purchase.where(["balance > 0  and  company_id = ? AND date1 >= ? and date1<= ? and supplier_id = ?", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", cliente ]).order(:supplier_id,:moneda_id,:date1)
    return @facturas


 end 

 
 def get_purchaseorders_day_value2(fecha1,fecha2,supplier,moneda,value )

    facturas = Purchaseorder.where(["company_id = ? AND fecha1 >= ? and fecha1<= ? and supplier_id = ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59",supplier, moneda ]).order(:supplier_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total.round(2)
      end
    end
    end 

    return ret
    
 end 

def get_purchases_pendientes_day_supplier(fecha1,fecha2,value,moneda)

    facturas = Purchase.where(["balance>0  and  company_id = ? AND date1 >= ? and date1 <= ? AND customer_id = ? and moneda_id =  ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", value , moneda ]).order(:customer_id,:moneda_id)

    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.balance.round(2)
      end
    end
    end 

    return ret    
 end 

def get_supplier_payments2(moneda)

   @facturas = Purchase.find_by_sql(["
  SELECT   year_month as year_month,
   supplier_id,
   SUM(balance) as balance   
   FROM purchases
   WHERE moneda_id = ? and balance>0
   GROUP BY 2,1
   ORDER BY 2,1 ", moneda])    

  return @facturas
    
 end 

 def get_supplier_payments_value2(fecha1,fecha2)

    ret = 0 
    if facturas 
    ret=0  
      for factura in facturas      

          ret += factura.total

      end
    end 
    return ret    
 end 


  
  # Return value for user
  def get_invoices_value_user(user, year, value = "total")
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND user_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, user.id, "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Return value for user in specific date
  def get_invoices_value_user_date(user, date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND user_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, user.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Return products for company
  def get_products()
    products = Product.where(company_id: self.id).order('name')
    
    return products
  end

  # Return products for company
  def get_products2()
    products = Product.where(company_id: self.id).order(:products_category_id,:code)    
    return products
  end
  
  # Return products for company
  def get_products_dato(id)
    products = Product.find_by(company_id: self.id,id: id)    
    if products.unidad == nil
    return products.name + " - "   
    else     
    return products.name + " - "+products.unidad 
    end 
  end
  
  # Return value for product
  def get_invoices_value_product(product, year, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59"])
    ids = []
    
    for invoice in invoices
      ids.push(invoice.id)
    end
    
    begin
      invoice_products = InvoiceProduct.where(["product_id = ? AND invoice_id IN (#{ids.join(",")})", product.id])
    rescue
      return 0
    end
    
    ret = 0
    
    for ip in invoice_products
      if(value == "quantity")
        ret += ip.quantity
      else
        ret += ip.total
      end
    end
    
    return ret
  end
  
  # Return value for product for exact date
  def get_invoices_value_product_date(product, date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ids = []
    
    for invoice in invoices
      ids.push(invoice.id)
    end
    
    begin
      invoice_products = InvoiceProduct.where(["product_id = ? AND invoice_id IN (#{ids.join(",")})", product.id])
    rescue
      return 0
    end
    
    ret = 0
    
    for ip in invoice_products
      if(value == "quantity")
        ret += ip.quantity
      else
        ret += ip.total
      end
    end
    
    return ret
  end
  
  # Get customers for Company
  def get_customers()
    customers = Customer.where(company_id: self.id).order(:name)

    return customers
  end
  
  # Get value for customer in year
  def get_invoices_value_customer(customer, year, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND customer_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, customer.id, "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end

  # Return value for customer in specific date
  def get_invoices_value_customer_date(customer, date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND customer_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, customer.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end

  # Get locations for company
  def get_report_locations()
    locations = Location.where(company_id: self.id)

    return locations
  end

  # Return value for location in year
  def get_invoices_value_location(location, year, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND location_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, location.id, "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Return value for location specific date
  def get_invoices_value_location_date(location, date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND location_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, location.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Returns divisions for company
  def get_report_divisions()
    divisions = Division.where(company_id:  self.id)

    return divisions
  end
  
  # Return value for a division year
  def get_invoices_value_division(division, year, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND division_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, division.id, "#{year}-01-01 00:00:00", "#{year}-12-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Return value for a division exact date
  def get_invoices_value_division_date(division, date, value)
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND division_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, division.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      if(value == "subtotal")
        ret += invoice.subtotal
      elsif(value == "tax")
        ret += invoice.tax
      else
        ret += invoice.total
      end
    end
    
    return ret
  end
  
  # Get profit, cost and taxes for a series of invoices in a date
  def get_ptc_value_date(date, value)
    date_arr = date.split("-")
    year = date_arr[0]
    month = date_arr[1]
    
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, "#{year}-#{month}-01 00:00:00", "#{year}-#{month}-31 23:59:59"])
    ret = 0
    
    for invoice in invoices
      products = invoice.get_products
      
      for product in products
        if(value == "profit")
          ret += product.profit * product.curr_quantity
        elsif(value == "tax")
          ret += product.tax * product.curr_quantity
        elsif(value == "price")
          ret += product.price * product.curr_quantity
        elsif(value == "total")
          ret += (product.price + product.tax) * product.curr_quantity
        else
          ret += product.cost * product.curr_quantity
        end
      end
    end
    
    return ret
  end
  
  # Get profit, cost and taxes for a series of invoices in an exact date
  def get_ptc_value_exact_date(date, value)
    
    invoices = Invoice.where(["invoices.return = '0' AND company_id = ? AND date_processed >= ? AND date_processed <= ?", self.id, "#{date} 00:00:00", "#{date} 23:59:59"])
    ret = 0
    
    for invoice in invoices
      products = invoice.get_products
      
      for product in products
        if(value == "profit")
          ret += product.profit * product.curr_quantity
        elsif(value == "tax")
          ret += product.tax * product.curr_quantity
        elsif(value == "price")
          ret += product.price * product.curr_quantity
        elsif(value == "total")
          ret += (product.price + product.tax) * product.curr_quantity
        else
          ret += product.cost * product.curr_quantity
        end
      end
    end
    
    return ret
  end


  def truncate(truncate_at, options = {})
  return dup unless length > truncate_at

  options[:omission] ||= '...'
  length_with_room_for_omission = truncate_at - options[:omission].length
  stop =        if options[:separator]
      rindex(options[:separator], length_with_room_for_omission) || length_with_room_for_omission
    else
      length_with_room_for_omission
    end

  "#{self[0...stop]}#{options[:omission]}"
  end

def get_purchaseorder_detail2(fecha1,fecha2)
    @purchaseorders = Purchaseorder.where([" fecha1 >= ? and fecha1 <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).order(:supplier_id,:moneda_id,:fecha1)
    return @purchaseorders    
 end 
  

 def get_purchaseorder_detail(fecha1,fecha2)
    @purchaseorders = Purchaseorder.where([" fecha1 >= ? and fecha1 <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).order(:fecha1)
    return @purchaseorders    
 end 

 def get_orden_detalle(id)
    
    @purchaseorders = PurchaseorderDetail.where(:purchaseorder_id=>id)
    return @purchaseorders
    
 end 
 def get_orden_detalle2(id)
    
    @purchaseorders = ServiceorderService.where(:serviceorder_id=>id)
    return @purchaseorders
    
 end 

 def get_purchase_detalle(id)    
    @purchases = PurchaseDetail.where(:purchase_id=>id)
    return @purchases
    
 end 


  def get_purchaseorders_day_value(fecha1,fecha2,value = "balance",moneda)

    facturas = Purchaseorder.where(["balance>0  and  company_id = ? AND date1 >= ? and date1<= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).order(:supplier_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.balance.round(2)
      end
    end
    end 

    return ret
    
 end 
 def get_purchaseorders_totalday_value(fecha1,fecha2,value = "total",moneda)

    facturas = Purchaseorder.where(["company_id = ? AND fecha1 >= ? and fecha1<= ? and moneda_id = ? ", self.id, "#{fecha1} 00:00:00","#{fecha2} 23:59:59", moneda ]).order(:supplier_id,:moneda_id)
    if facturas
    ret=0  
    for factura in facturas
      
      if(value == "subtotal")
        ret += factura.subtotal
      elsif(value == "tax")
        ret += factura.tax
      else         
        ret += factura.total.round(2)
      end
    end
    end 

    return ret    
 end 


 ###INVENTARIO  STOCKS 

 def get_stocks_inventarios2(fecha1,fecha2,product1)

    MovementDetail.delete_all


    @productExiste = Product.where(:products_category_id=> product1) 

     for existe in @productExiste

        product =  MovementDetail.find_by(:product_id => existe.id)

        if product 
        else   
          detail  = MovementDetail.new(:fecha=>fecha1 ,:stock_inicial=>0,:ingreso=>0,:salida =>0,
         :price=> existe.price ,:product_id=> existe.id,:tm=>"4")
          detail.save       
        end         
     end    

     @inv = Inventario.where('fecha >= ? and  fecha <= ?',fecha1,fecha2)  

     for inv in @inv 
        $lcFecha =inv.fecha 
        @invdetail=  InventarioDetalle.where(:inventario_id=>inv.id)
        for invdetail in @invdetail 
           movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          
        if movdetail   
            movdetail.ingreso += invdetail.cantidad
            movdetail.price = invdetail.precio_unitario
            movdetail.save 
        else
        #  detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>invdetail.cantidad,
        #    :salida => 0,
        #  :price=>invdetail.precio_unitario,:product_id=> invdetail.product_id,:tm=>"1")
        #  detail.save 
        end   

        end 
      end 
      #ingresos
     @ing = Purchase.where('date1>= ? and date1 <= ?',fecha1,fecha2)

     for ing in @ing
        $lcFecha = ing.date1
        $lcmoneda = ing.moneda_id

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)
    
        for detail in @ingdetail 
          
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          
        
          if movdetail
            if detail.quantity == nil 
              movdetail.ingreso = 0
            else 
              movdetail.ingreso += detail.quantity
            end 
            if detail.price_without_tax == nil
             movdetail.price = 0 
            else
              if $lcmoneda != nil
                if $lcmoneda == 2
                 movdetail.price = detail.price_without_tax  
                else
                 dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                 if dolar 
                    movdetail.price = detail.price_without_tax * dolar.compra  
                 else 
                    movdetail.price = 0
                 end 
                end    
              end 
            end 
            movdetail.save           
          else     
         # detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>detail.quantity,:salida => 0,
         #   :price=>detail.price_without_tax,:product_id=> detail.product_id,:tm =>"2")
         # detail.save 
          end

        end 
     end 

     #salidas 
    @sal  = Output.where('fecha>= ? and fecha <= ?',fecha1,fecha2)

     for sal in @sal 
        $lcFecha = sal.fecha 

        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 

          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida += detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end   
        end 
     end 

     ######################################################################3
     ##saldo inicial
     ######################################################################3 

     @inv = Inventario.where('fecha < ?',fecha1)  

    
     for inv in @inv       

        @invdetail = InventarioDetalle.where(:inventario_id=>inv.id)

        for invdetail in @invdetail 

          
           movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          

          if movdetail

            if invdetail.cantidad == nil
            movdetail.stock_inicial = 0   
            else
            movdetail.stock_inicial += invdetail.cantidad
            end

            if invdetail.precio_unitario == nil
              movdetail.price = 0  
           else 
              movdetail.price = invdetail.precio_unitario
            end

            movdetail.save           
          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 
          end
        
        end 
      end 

      #ingresos
     @ing = Purchase.where('date1 <  ? ',fecha1)

     for ing in @ing    

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)

        for detail in @ingdetail 

         movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.stock_inicial = 0   
            else
              movdetail.stock_inicial += detail.quantity
            end

            if detail.price_without_tax == 0
              movdetail.price = 0  
            else 
              if $lcmoneda != nil
                if $lcmoneda == 2
                 movdetail.price = detail.price_without_tax  
                else
                 #dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                selected_date = Date.parse($lcFecha)
                  # This will look for records on the given date between 00:00:00 and 23:59:59
                sh = Tipocambio.where(
                  :created_at => selected_date.beginning_of_day..selected_date.end_of_day)

                 if sh  
                    movdetail.price = detail.price_without_tax * dolar.compra  
                 else 
                    movdetail.price = 0
                 end 
                end    
              end 

            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
                
        end 
     end 

     #salidas 
    @sal  = Output.where('fecha <  ?',fecha1)
     for sal in @sal     
        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 
        
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida -= detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price 
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
        end 
     end 

     # AGREGA LOS QUE NO TIENEN MOVIMIENTO 
    
      @inv = MovementDetail.all.order(:product_id,:fecha)
    return @inv 

 end


 ###INVENTARIO  STOCKS  DETALLADO

 def get_stocks_inventarios3(fecha1,fecha2,product1)

    MovementDetail.delete_all
    @productExiste = Product.where(:products_category_id=> product1) 
     for existe in @productExiste
        product =  MovementDetail.find_by(:product_id => existe.id)
        if product
        else
          detail  = MovementDetail.new(:fecha=>fecha1 ,:stock_inicial=>0,:ingreso=>0,:salida =>0,
         :price=> existe.price ,:product_id=> existe.id,:tm=>"4")
          detail.save
        end        
     end    

     @inv = Inventario.where('fecha >= ? and  fecha <= ?',fecha1,fecha2)  
     for inv in @inv 
        $lcFecha =inv.fecha 
        @invdetail=  InventarioDetalle.where(:inventario_id=>inv.id)
        for invdetail in @invdetail 
           movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          
        if movdetail   
            movdetail.ingreso += invdetail.cantidad
            movdetail.price = invdetail.precio_unitario
            movdetail.save 
        else
        #  detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>invdetail.cantidad,
        #    :salida => 0,
        #  :price=>invdetail.precio_unitario,:product_id=> invdetail.product_id,:tm=>"1")
        #  detail.save 
        end   
        end 
      end 

      #ingresos
     @ing = Purchase.where('date1>= ? and date1 <= ?',fecha1,fecha2)

     for ing in @ing
        $lcFecha = ing.date1
        $lcmoneda = ing.moneda_id

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)
    
        for detail in @ingdetail 
          
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          
        
          if movdetail

            
            if detail.quantity == nil 
              movdetail.ingreso = 0
            else 
              movdetail.ingreso += detail.quantity
            end 

            if detail.price_without_tax == nil
             movdetail.price = 0 
            else
              if $lcmoneda != nil
                if $lcmoneda == 2
                 movdetail.price = detail.price_without_tax
                else
                 dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                 if dolar 
                    movdetail.price = detail.price_without_tax * dolar.compra  
                 else 
                    movdetail.price = 0
                 end 
                end    
              end 
            end 

            movdetail.save           
          else     
         # detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>detail.quantity,:salida => 0,
         #   :price=>detail.price_without_tax,:product_id=> detail.product_id,:tm =>"2")
         # detail.save 
          end

        end 
     end 

     #salidas 
    @sal  = Output.where('fecha>= ? and fecha <= ?',fecha1,fecha2)

     for sal in @sal 
        $lcFecha = sal.fecha 

        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 

          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida += detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end   
        end 
     end 

     ######################################################################3
     ##saldo inicial
     ######################################################################3 

     @inv = Inventario.where('fecha < ?',fecha1)  

    
     for inv in @inv       

        @invdetail = InventarioDetalle.where(:inventario_id=>inv.id)

        for invdetail in @invdetail 

          
           movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          

          if movdetail

            if invdetail.cantidad == nil
            movdetail.stock_inicial = 0   
            else
            movdetail.stock_inicial += invdetail.cantidad
            end

            if invdetail.precio_unitario == nil
              movdetail.price = 0  
           else 
              movdetail.price = invdetail.precio_unitario
            end

            movdetail.save           
          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 
          end
        
        end 
      end 

      #ingresos
     @ing = Purchase.where('date1 <  ? ',fecha1)

     for ing in @ing    

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)

        for detail in @ingdetail 

         movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.stock_inicial = 0   
            else
              movdetail.stock_inicial += detail.quantity
            end

            if detail.price_without_tax == 0
              movdetail.price = 0  
            else 
              if $lcmoneda != nil
                if $lcmoneda == 2
                 movdetail.price = detail.price_without_tax  
                else
                 dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                 if dolar 
                    movdetail.price = detail.price_without_tax * dolar.compra  
                 else 
                    movdetail.price = 0
                 end 
                end    
              end 

            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
                
        end 
     end 

     #salidas 
    @sal  = Output.where('fecha <  ?',fecha1)
     for sal in @sal     
        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 
        
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida -= detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price 
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
        end 
     end 

     # AGREGA LOS QUE NO TIENEN MOVIMIENTO 
    
      @inv = MovementDetail.all.order(:product_id,:fecha)
    return @inv 

 end

def get_stocks_ingresos2   

    return @ing 
 end

def get_stocks_salidas2   
     
    return @sal 
 end
 

 def get_stocks(categoria)
  @stocks = Stock.find_by_sql(['Select stocks.*
    from stocks 
RIGHT JOIN products ON stocks.product_id = products.id
WHERE products.products_category_id = ? ORDER BY products.code  ',categoria ]) 
  return @stocks 

 end 
 def get_movement_stocks(fecha1,fecha2,product)

    MovementDetail.delete_all

    @productExiste = Product.where(:products_category_id=> product1) 

     for existe in @productExiste
        product =  MovementDetail.find_by(:product_id => existe.id)
        if product 
        else   
          detail  = MovementDetail.new(:fecha=>fecha1 ,:stock_inicial=>0,:ingreso=>0,:salida =>0,
         :price=> existe.price ,:product_id=> existe.id,:tm=>"4")
          detail.save       
        end         
     end    

     @inv = Inventario.where('fecha >= ? and  fecha <= ?',fecha1,fecha2)  

     for inv in @inv 

        $lcFecha   =  inv.fecha 

        @invdetail =  InventarioDetalle.where(:inventario_id=>inv.id)

        for invdetail in @invdetail         
            movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          
            if movdetail   

                detail  = MovementDetail.new(:fecha=> $lcFecha ,:stock_inicial=>0,:ingreso=> invdetail.cantidad,:salida =>0,
                  :price=> invdetail.precio_unitario ,:product_id=> invdetail.product_id,:tm=>"4")
                detail.save       
              
            else
              #  detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>invdetail.cantidad,
              #    :salida => 0,
              #  :price=>invdetail.precio_unitario,:product_id=> invdetail.product_id,:tm=>"1")
              #  detail.save 
            end   

        end 
      end 
      #ingresos
     @ing = Purchase.where('date1>= ? and date1 <= ?',fecha1,fecha2)

     for ing in @ing
        $lcFecha = ing.date1
        $lcmoneda = ing.moneda_id

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)    
        for detail in @ingdetail           
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)                  
          if movdetail
            if detail.quantity == nil 
              $lcingreso = 0
            else 

              $lcingreso += detail.quantity
            end 

            if detail.price_without_tax == nil
             $lcprice = 0 
            else
              if $lcmoneda != nil
                if $lcmoneda == 2
                  $lcprice = detail.price_without_tax  
                else
                 dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                 if dolar 
                    $lcprice = detail.price_without_tax * dolar.compra  
                 else 
                    $lcprice = 0
                 end 
                end    
              end 
            end   

            detail_ing  = MovementDetail.new(:fecha=> $lcFecha ,:stock_inicial=>0,:ingreso=> detail.quantity,:salida =>0,
                  :price=> $lcprice ,:product_id=> detail.product_id,:tm=>"3")
            detail_ing.save                   

          
          else     
         # detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>detail.quantity,:salida => 0,
         #   :price=>detail.price_without_tax,:product_id=> detail.product_id,:tm =>"2")
         # detail.save 
          end

        end 
     end 

     #salidas 
    @sal  = Output.where('fecha>= ? and fecha <= ?',fecha1,fecha2)

     for sal in @sal 
        $lcFecha = sal.fecha 

        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 

          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida += detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end   
        end 
     end 

     ######################################################################3
     ##saldo inicial
     ######################################################################3 

     @inv = Inventario.where('fecha < ?',fecha1)  

    
     for inv in @inv       

        @invdetail = InventarioDetalle.where(:inventario_id=>inv.id)

        for invdetail in @invdetail 

          
           movdetail  = MovementDetail.find_by(:product_id=>invdetail.product_id)          

          if movdetail

            if invdetail.cantidad == nil
            movdetail.stock_inicial = 0   
            else
            movdetail.stock_inicial += invdetail.cantidad
            end

            if invdetail.precio_unitario == nil
              movdetail.price = 0  
           else 
              movdetail.price = invdetail.precio_unitario
            end

            movdetail.save           
          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 
          end
        
        end 
      end 

      #ingresos
     @ing = Purchase.where('date1 <  ? ',fecha1)

     for ing in @ing    

        @ingdetail=  PurchaseDetail.where(:purchase_id=>ing.id)

        for detail in @ingdetail 

         movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.stock_inicial = 0   
            else
              movdetail.stock_inicial += detail.quantity
            end

            if detail.price_without_tax == 0
              movdetail.price = 0  
            else 
              if $lcmoneda != nil
                if $lcmoneda == 2
                 movdetail.price = detail.price_without_tax  
                else
                 dolar = Tipocambio.find_by('dia = ?',$lcFecha)

                 if dolar 
                    movdetail.price = detail.price_without_tax * dolar.compra  
                 else 
                    movdetail.price = 0
                 end 
                end    
              end 

            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
                
        end 
     end 

     #salidas 
    @sal  = Output.where('fecha <  ?',fecha1)
     for sal in @sal     
        @saldetail=  OutputDetail.where(:output_id=>sal.id)

        for detail in @saldetail 
        
          movdetail  = MovementDetail.find_by(:product_id=>detail.product_id)          

          if movdetail

            if detail.quantity == nil
              movdetail.salida = 0   
            else
              movdetail.salida -= detail.quantity
            end

            if detail.price == 0
              movdetail.price = 0  
            else 
              #para las salidas toma el precio de costo ya validado en soles 
              movdetail.price = detail.price 
            end

            movdetail.save           

          else     
          
            #detail  = MovementDetail.new(:fecha=>$lcFecha ,:ingreso=>0,:salida =>detail.quantity,
            #:price=>detail.price,:product_id=> detail.product_id,:tm=>"3")
            #detail.save 

          end
        
        end 
     end 

     # AGREGA LOS QUE NO TIENEN MOVIMIENTO 
    
      @inv = MovementDetail.all.order(:product_id,:fecha)
    return @inv 




 end
def get_salidas_day(fecha1,fecha2,product)
  
    @purchases = Output.find_by_sql(['Select outputs.*,output_details.quantity,
    output_details.price,output_details.total,products.name as nameproducto,products.code as codigo,products.unidad
    from output_details   
INNER JOIN outputs ON output_details.output_id = outputs.id
INNER JOIN products ON output_details.product_id = products.id
WHERE output_details.product_id = ?  and outputs.fecha > ? and outputs.fecha < ?',product, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
 
    return @purchases 

end

def get_salidas_day2(fecha1,fecha2,product)
  
    @purchases = Output.find_by_sql(['Select outputs.*,output_details.quantity,
    output_details.price,output_details.total,products.name as nameproducto,products.code as codigo,products.unidad
    from output_details   
INNER JOIN outputs ON output_details.output_id = outputs.id
INNER JOIN products ON output_details.product_id = products.id
WHERE products.products_category_id = ?  and outputs.fecha > ? and outputs.fecha < ?',product, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
 
    return @purchases 

end


def get_ingresos_day(fecha1,fecha2,product)
  
    @purchases = Purchase.find_by_sql(['Select purchases.*,purchase_details.quantity,
    purchase_details.price_without_tax as price,purchases.date1 as fecha, products.name as nameproducto,
    products.code as codigo ,purchases.documento as code ,products.unidad,purchase_details.total 
    from purchase_details   
INNER JOIN purchases ON purchase_details.purchase_id = purchases.id
INNER JOIN products ON purchase_details.product_id = products.id
WHERE purchase_details.product_id = ?  and purchases.date1 > ? and purchases.date1 < ? ' ,product, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
 
    return @purchases 

end

def get_ingresos_day2(fecha1,fecha2,product)
  
   @purchases = Purchase.find_by_sql(['Select purchases.*,purchase_details.quantity,
    purchase_details.price_without_tax as price,purchases.date1 as fecha, products.name as nameproducto,
    products.code as codigo ,purchases.documento as code ,products.unidad,purchase_details.total 
    from purchase_details   
INNER JOIN purchases ON purchase_details.purchase_id = purchases.id
INNER JOIN products ON purchase_details.product_id = products.id
WHERE products.products_category_id = ?  and purchases.date1 > ? and purchases.date1 < ?
ORDER BY products.code  ',product, "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
 
    return @purchases 

end


def get_ingresos_day3(fecha1,fecha2)  
    @purchases = Purchaseorder.where(["fecha1 >= ? and fecha1 <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
    return @purchases 

end

def get_contratos_day(fecha1,fecha2)    
    @contratos = Contrato.where(["fecha >= ? and fecha <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).order(:customer_id,:medio_id,:moneda_id,:fecha)
    return @contratos
end 

def get_contratos_day_customer(fecha1,fecha2,customer)    
    @contratos = Contrato.where(["fecha >= ? and fecha <= ?  and customer_id=?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).order(:customer_id,:medio_id,:moneda_id,:fecha)
    return @contratos
end 


def get_contratos_medio(fecha1,fecha2)    
    @contratos = Contrato.select("medio_id").where(["fecha >= ? and fecha <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).group(:medio_id).order(:medio_id)
    return @contratos
end 
def get_contratos_medio_canal(fecha1,fecha2,medio)    
    @contratos = Contrato.where(["fecha >= ? and fecha <= ? and medio_id=?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio ]).group(:medio_id).order(:medio_id)
    return @contratos
end 

def get_contratos_medio1(fecha1,fecha2)    
    @contratos = Contrato.select("medio_id").joins(:contrato_details).where(["contratos.fecha >= ? and contratos.fecha <= ? and contrato_details.factura1 is not null and contrato_details.sit != ?  ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59","1" ]).group(:medio_id).order(:medio_id)
    return @contratos
end


def get_contratos_medio_canal1(fecha1,fecha2,medio)    
    @contratos = Contrato.select("medio_id").joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contrato_details.factura1 
      is not null and contrato_details.sit != ? and contratos.medio_id = ? ",
       "#{fecha1} 00:00:00","#{fecha2} 23:59:59","1",medio ])
    .group(:medio_id).order(:medio_id)
    return @contratos
end 



def get_contratos_medio2(fecha1,fecha2)    
    @contratos = Contrato.select("medio_id").joins(:contrato_details).where(["contratos.fecha >= ? 
      and contratos.fecha <= ? and contrato_details.facturacanal <> ? and
      contrato_details.factura1 = ?  ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59","","" ]).group(:medio_id).order(:medio_id)
    return @contratos
end


def get_contratos_medio_canal2(fecha1,fecha2,medio)    
    @contratos = Contrato.select("medio_id").joins(:contrato_details).
    where(["contratos.fecha >= ? and contratos.fecha <= ? and contrato_details.facturacanal <> ? and
      contrato_details.factura1 = ? and medio_id =? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59","","" ,medio ])
    .group(:medio_id).order(:medio_id)
    return @contratos
end 



def get_contratos_medio_customer(fecha1,fecha2,medio)    
    @contratos = Contrato.where(["fecha >= ? and fecha <= ? and medio_id=?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio ]).group(:medio_id).order(:medio_id)
    return @contratos
end 



def get_contratos_customer_contrato(fecha1,fecha2,medio,customer)    
    @contratos = Contrato.where(["fecha >= ? and fecha <= ? and medio_id=?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",medio,customer ]).group(:code).order(:code)
    return @contratos
end 

#####

def get_contratos_medio_anio(fecha1,fecha2)    
    @contratos = Contrato.select("medio_id").where(["fecha >= ? and fecha <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).group(:medio_id).order(:medio_id)
    return @contratos
end 



#####
def get_orden_mesanio    

    @factura = Orden.where(:mesanio => nil)
    for factura in @factura
        f = Orden.find(factura.id)
          if f
            a = f.year.to_s
            b = f.month.to_s.rjust(2, '0')

            f.mesanio = a + b 
          

            f.save
          end 
    end 
   @factura = ContratoAbono.where(:mesanio=> nil)
    for factura in @factura
        f = ContratoAbono.find(factura.id)
      if f
        @fechas =f.fecha.to_s
        parts = @fechas.split("-")
        year = parts[0]
        mes  = parts[1]
        dia  = parts[2]      
        f.mesanio  = year+mes 
        f.save
      end 
    end 


end 
def get_ordenes_eecc(mes1,anio1,mes2,anio2)    
  mes0 = ""
  anio0 =  ""

   mes0   = anio1 + mes1.to_s.rjust(2, '0')
   anio0  = anio2 + mes2.to_s.rjust(2, '0')


     @contratos = Orden.find_by_sql(["
     SELECT  customer_id,medio_id, secu_cont, moneda_id,
       SUM(total) as balance   
       FROM Ordens 
       WHERE mesanio  >= ?  and mesanio <=?   and processed = ?
       GROUP BY 1,2,3,4
       ORDER BY 1,2,3,4 ", "#{mes0}","#{anio0}","1" ])  

     #@contratos = Orden.select("customers.ruc,ordens.customer_id").group( "customers.ruc,ordens.customer_id").joins(:customer).order("customers.ruc")

    return @contratos
end 




def get_ordenes_eecc_cliente(mes1,anio1,mes2,anio2,customer)    

    @factura = Orden.where(:month => nil)
    for factura in @factura
        f = Orden.find(factura.id)
      if f
        @fechas =f.fecha.to_s
        parts = @fechas.split("-")
        anio = parts[0]
        mes  = parts[1]
        dia  = parts[2]      
        f.month = mes
        f.year = anio 
        f.save
      end 
    end 
  

   mes0   = anio1 + mes1.to_s.rjust(2, '0')
   anio0  = anio2 + mes2.to_s.rjust(2, '0')

   puts mes0
   puts anio0



     @contratos = Orden.find_by_sql(["
     SELECT  customer_id,medio_id, secu_cont, moneda_id,
       SUM(total) as balance   
       FROM Ordens 
       WHERE mesanio  >= ?  and mesanio<=?  and customer_id = ? and processed = ?
       GROUP BY 1,2,3,4
       ORDER BY 1,2,3,4 ", "#{mes0}","#{anio0}" ,customer ,"1" ])  

     #@contratos = Orden.select("customers.ruc,ordens.customer_id").group( "customers.ruc,ordens.customer_id").joins(:customer).order("customers.ruc")


    return @contratos
end 


def get_saldo_cliente_contrato(customer,medio,contrato,moneda,fecha1)

      a = Orden.find_by(["fecha1>=? and fecha2 < ? and customer_id =? and medio_id =? and contrato_id =? 
        and moneda_id =?","2019-01-01 00:00:00", "#{fecha1} 00:00:00",customer,medio,contrato.moneda ])

      return a   

      
  
end




def get_statamenacount_by_day(fecha1,fecha2,banco)
     a= Stamentacount.find_by(["fecha1 >= ? and fecha2<=? and bank_acount_id =?","#{fecha1} 00:00:00","#{fecha2} 23:59:59",banco])

    if a.nil?
      return 0
    else  
      return a.saldo_final 
    end 

end 

def get_concilia_by_day(fecha1,fecha2,banco)
     a= Conciliabank.find_by(["fecha1 >= ? and fecha2<=? and bank_acount_id =?","#{fecha1} 00:00:00","#{fecha2} 23:59:59",banco])

    if a.nil?
      return 0
    else  
      return a   
    end 

end 

def get_concilia_by_days(id)
     a= ConciliabankDetail.where(conciliabank_id: id )

   
      return a
  

end 


def get_statamenacount_by_days(fecha1,fecha2,banco)

     a = SupplierPayment.where(["fecha1 >= ? and fecha1 <= ? and bank_acount_id = ? ","#{fecha1} 00:00:00","#{fecha2} 23:59:59",banco])
     
     b = Stamentacount.find_by (["fecha1 >= ? and fecha2 <= ? and bank_acount_id = ? ","#{fecha1} 00:00:00","#{fecha2} 23:59:59",banco])
     

      Conciliation.delete_all 
  if a.size > 0
      for @cheques in a 

          unless b.nil?

          f = StamentacountDetail.find_by(stamentacount_id: b.id,nrocheque: @cheques.documento) 

          if f.nil? 

              c = Conciliation.new( bank_acount_id: b.bank_acount_id, 
              documento: @cheques.documento  , total: @cheques.total, fecha1: @cheques.fecha1,
              descrip: @cheques.get_supplier(@cheques.supplier_id) )   
             begin 
             c.save
              rescue
             end 
          else
            

          end 
          end 

        end 

        conciliacion = Conciliation.all 
  end 

  return conciliacion 

end 

def get_tipo_orden

    a = TipoOrden.order(:code )

    return a
end 

def get_tipo_aviso

    a = TipoAviso.order(:code ).all 

    return a
end 

def get_tipo_tarifa

    a = TipoTarifa.order(:code ).all 

    return a
end 



def get_ordenes_day(fecha1,fecha2)    
    @ordenes = Orden.where(["fecha >= ? and fecha <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])
    return @ordenes
    
 end 

def get_ordenes_cliente(fecha1,fecha2,cliente)    
    @ordenes = Orden.where(["fecha >= ? and fecha <= ?  and customer_id = ?", "#{fecha1} 00:00:00","#{fecha2} 23:59:59",cliente ])
    return @ordenes
    
 end 

  def get_ordenes_cliente_all0(mes,anio,mes1,anio1,cliente,medio,marca,producto,version,ciudad,tipoorden)    
   
   sql_dato =""
   sql_dato1 =""
   sql_dato2 =""
   sql_dato3 =""
   sql_dato4 =""
   sql_dato5 =""
   sql_dato6 =""
   
  if cliente != ""
    sql_dato <<  "customer_id = " << cliente 
  end 
  
  
  if medio != ""
    
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    puts sql_dato 
    
    sql_dato << txt_and << "medio_id = " << medio
  end 
  
  
  if marca != ""
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    
    sql_dato << txt_and << "marca_id =" << marca
  end 
  
  if producto != ""
    
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "producto_id =" << producto
  end 
  
  if version != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "version_id =" << version 
  end 
  
  if ciudad != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "ciudad_id =" << ciudad 
  end 
  
  if tipoorden != "3"
    if tipoorden == "2"
       tipo= "D"
      sql_dato << "tipo = 'D' "  
    end 
    if tipoorden == "1"
       tipo= "N"
      sql_dato << "tipo = 'N'  "  
      
    end 
  end 
  
  if sql_dato ==  ""
   @ordenes = Orden.where(["month >= ? and year >= ? and month <= ? and year <= ? and 
    processed = ? ", "#{mes}","#{anio}", "#{mes1}","#{anio1}" ,"1"]).order(:customer_id,:medio_id)
  else
   @ordenes = Orden.where(["month >= ? and year >= ? and month <= ? and year <= ? and
    processed = ? and #{sql_dato}", "#{mes} ","#{anio} ", "#{mes1}","#{anio1}" ,"1" ]).order(:customer_id,:medio_id)
  end 
  puts "sql " 
  puts sql_dato

  puts "**"
 puts "#{mes}"
 puts "#{anio}"
 puts  "#{mes1}"
 puts "#{anio1}"

 
  return @ordenes
    
 end 


 def get_ordenes_cliente_all(mes,anio,mes1,anio1,cliente,medio,marca,producto,version,ciudad,tipoorden)    
   
   sql_dato =""
   sql_dato1 =""
   sql_dato2 =""
   sql_dato3 =""
   sql_dato4 =""
   sql_dato5 =""
   sql_dato6 =""
   
  if cliente != ""
    sql_dato <<  "customer_id = " << cliente 
  end 
  
  
  if medio != ""
    
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    puts sql_dato 
    
    sql_dato << txt_and << "medio_id = " << medio
  end 
  
  
  if marca != ""
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    
    sql_dato << txt_and << "marca_id =" << marca
  end 
  
  if producto != ""
    
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "producto_id =" << producto
  end 
  
  if version != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "version_id =" << version 
  end 
  
  if ciudad != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "ciudad_id =" << ciudad 
  end 
  
  if tipoorden != "3"
    if tipoorden == "2"
       tipo= "D"
      sql_dato << "tipo = 'D' "  
    end 
    if tipoorden == "1"
       tipo= "N"
      sql_dato << "tipo = 'N'  "  
      
    end 
  end 
  
  if sql_dato ==  ""
   @ordenes = Orden.select(:customer_id ).where(["month >= ? and year >= ? and month <= ? and year <= ? and 
    processed = ? ", "#{mes}","#{anio}", "#{mes1}","#{anio1}" ,"1"]).group(:customer_id).order(:customer_id)
  else
   @ordenes = Orden.select(:customer_id).where(["month >= ? and year >= ? and month <= ? and year <= ? and
    processed = ? and #{sql_dato}", "#{mes} ","#{anio} ", "#{mes1}","#{anio1}" ,"1" ]).group(:customer_id).order(:customer_id)
  end 
  puts "sql " 
  puts sql_dato

  puts "**"
 puts "#{mes}"
 puts "#{anio}"
 puts  "#{mes1}"
 puts "#{anio1}"

 
  return @ordenes
    
 end 


 def get_ordenes_cliente_all2(mes,anio,mes1,anio1,cliente,medio,marca,producto,version,ciudad,tipoorden)    
   
   sql_dato =""
   sql_dato1 =""
   sql_dato2 =""
   sql_dato3 =""
   sql_dato4 =""
   sql_dato5 =""
   sql_dato6 =""
   
  if cliente != ""
    sql_dato <<  "customer_id = " << cliente 
  end 
  
  
  if medio != ""
    
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    puts sql_dato 
    
    sql_dato << txt_and << "medio_id = " << medio
  end 
  
  
  if marca != ""
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    
    sql_dato << txt_and << "marca_id =" << marca
  end 
  
  if producto != ""
    
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "producto_id =" << producto
  end 
  
  if version != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "version_id =" << version 
  end 
  
  if ciudad != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "ciudad_id =" << ciudad 
  end 
  
  if tipoorden != "3"
    if tipoorden == "2"
       tipo= "D"
      sql_dato << "tipo = 'D' "  
    end 
    if tipoorden == "1"
       tipo= "N"
      sql_dato << "tipo = 'N'  "  
      
    end 
  end 
  
  if sql_dato ==  ""
   @ordenes = Orden.select(:medio_id).where(["month >= ? and year >= ? and month <= ? and year <= ? and 
    processed = ? ", "#{mes}","#{anio}", "#{mes1}","#{anio1}" ,"1"]).group(:medio_id).order(:medio_id)
  else
   @ordenes = Orden.select(:medio_id).where(["month >= ? and year >= ? and month <= ? and year <= ? and
    processed = ? and #{sql_dato}", "#{mes} ","#{anio} ", "#{mes1}","#{anio1}" ,"1" ]).group(:medio_id).order(:medio_id)
  end 
  puts "sql " 
  puts sql_dato

  puts "**"
 puts "#{mes}"
 puts "#{anio}"
 puts  "#{mes1}"
 puts "#{anio1}"

 
  return @ordenes
    
 end 

def get_ordenes_cliente_all3(mes,anio,mes1,anio1,cliente,medio,marca,producto,version,ciudad,tipoorden)    
   
   sql_dato =""
   sql_dato1 =""
   sql_dato2 =""
   sql_dato3 =""
   sql_dato4 =""
   sql_dato5 =""
   sql_dato6 =""
   
  if cliente != ""
    sql_dato <<  "customer_id = " << cliente 
  end 
  
  
  if medio != ""
    
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    puts sql_dato 
    
    sql_dato << txt_and << "medio_id = " << medio
  end 
  
  
  if marca != ""
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    
    sql_dato << txt_and << "marca_id =" << marca
  end 
  
  if producto != ""
    
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "producto_id =" << producto
  end 
  
  if version != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "version_id =" << version 
  end 
  
  if ciudad != ""
     if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
   
    sql_dato << txt_and << "ciudad_id =" << ciudad 
  end 
  
  if tipoorden != "3"
    if tipoorden == "2"
       tipo= "D"
      sql_dato << "tipo = 'D' "  
    end 
    if tipoorden == "1"
       tipo= "N"
      sql_dato << "tipo = 'N'  "  
      
    end 
  end 
  
  if sql_dato ==  ""
   @ordenes = Orden.where(["month >= ? and year >= ? and month <= ? and year <= ? and 
    processed = ? ", "#{mes}","#{anio}", "#{mes1}","#{anio1}" ,"1"]).order(:code)
  else
   @ordenes = Orden.where(["month >= ? and year >= ? and month <= ? and year <= ? and
    processed = ? and #{sql_dato}", "#{mes} ","#{anio} ", "#{mes1}","#{anio1}" ,"1" ]).order(:code)
  end 
  puts "sql " 
  puts sql_dato

  puts "**"
 puts "#{mes}"
 puts "#{anio}"
 puts  "#{mes1}"
 puts "#{anio1}"

 
  return @ordenes
    
 end 

 def get_ordenes_cliente2(fecha1,fecha2,cliente,medio)    
   
   sql_dato =""
   sql_dato1 =""
   sql_dato2 =""
   sql_dato3 =""
   sql_dato4 =""
   sql_dato5 =""
   sql_dato6 =""
   
  if cliente != ""
    sql_dato <<  " customer_id = " << cliente 
  end 
  
  
  if medio != ""
    
    if sql_dato != ""
    txt_and = " and "
    else 
      txt_and = ""
    end 
    puts sql_dato 
    
    sql_dato << txt_and << " medio_id = " << medio
  end 
  puts "sql 11" 
  puts sql_dato
  puts fecha1
  puts fecha2

  
  if sql_dato ==  ""
   @ordenes = Orden.where(["fecha >= ? and fecha <= ?  and processed = ? ", "#{fecha1}","#{fecha2}" ,"1"]).
   order(:customer_id,:medio_id)
   puts "2222"
  else
   @ordenes = Orden.where(["fecha >= ? and fecha <= ?  and processed = ? and #{sql_dato} ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ,"1" ]).
   order(:customer_id,:medio_id)
   puts "sql 333 " 
  puts sql_dato

  end 
  
  
 
  return @ordenes
    
 end 


 def get_ordenes_cliente3(fecha1,fecha2)    
   
       
       @ordenes = Orden.where(["fecha >= ? and fecha <= ?  and processed = ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ,"1" ]).
       order(:customer_id,:medio_id)
  
        return @ordenes
    
 end 


 def get_ordenes_cliente4(mes,anio,mes1,anio1)    
   
       
       @ordenes = Orden.where(["month >= ? and year >= ? and month <= ? and year <= ? and 
    processed = ? ", "#{mes}","#{anio}", "#{mes1}","#{anio1}" ,"1"]).order(:code)
  
        return @ordenes
    
 end 


 def get_facturas_medios(fecha1,fecha2)    
   
       
       @facturas = Factura.where(["fecha >= ? and fecha <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ]).
       order(:customer_id,:medio_id)
  
        return @facturas
    
 end 
 
 def get_customer_payments_cabecera(fecha1,fecha2)
  
      @payments = CustomerPayment.where(["company_id= ? and fecha1 >= ? and fecha1 <=?",self.id, "#{fecha1} 00:00:00" ,"#{fecha2} 23:59:59"])
      return @payments 
end 

 def get_customer_payments(fecha1,fecha2)
    @facturas =   CustomerPayment.find_by_sql(['Select customer_payments.id,customer_payment_details.total,
customer_payments.code  as code_liq,facturas.code,facturas.customer_id,facturas.fecha,
facturas.moneda_id,customer_payments.bank_acount_id,
customer_payment_details.factory,
customer_payments.fecha1,facturas.medio_id
from customer_payment_details   
INNER JOIN facturas ON   customer_payment_details.factura_id = facturas.id
INNER JOIN customer_payments ON customer_payments.id = customer_payment_details.customer_payment_id  
WHERE customer_payments.fecha1 >= ? and customer_payments.fecha1 <= ? order by customer_payments.code', "#{fecha1} 00:00:00",
"#{fecha2} 23:59:59" ])  
    
    return @facturas   
    
 end


 def get_customer_payments_value_otros_customer2(fecha1,fecha2,value,moneda_pago)

  facturas = CustomerPayment.find_by_sql(['Select  DISTINCT ON (1)  customer_payments.id,
  customer_payment_details.total,facturas.code,facturas.customer_id,facturas.medio_id,
  facturas.fecha,customer_payment_details.factory, 
  customer_payments.bank_acount_id
  from customer_payment_details   
  INNER JOIN facturas ON   customer_payment_details.factura_id = facturas.id
  INNER JOIN customer_payments ON customer_payments.id = customer_payment_details.customer_payment_id    
  WHERE customer_payments.fecha1 >= ? and customer_payments.fecha1 <= ? ', "#{fecha1} 00:00:00",
"#{fecha2} 23:59:59" ])

    ret = 0 
    ret1=0  
    ret2=0  
    

    if facturas 
      for factura in facturas  
      
          @banco = BankAcount.find(factura.bank_acount_id)
          moneda = @banco.moneda_id
          
          @detail = CustomerPaymentDetail.where(:customer_payment_id => factura.id)

          for d in @detail 
          
            if(value == "ajuste")
              if moneda == 2 
                ret2 += d.ajuste*-1
              else
                ret1 += d.ajuste*-1
              end 
            elsif (value == "compen")
              if moneda == 2 
                ret2 += d.compen 
              else 
                ret1 += d.compen 
              end 
            elsif (value == "total")
              if moneda == 2
                ret2 += d.compen   
              else
                ret1 += d.compen   
              end
            else         
              if moneda == 2
                ret2 += d.factory
              else
                ret1 += d.factory
              end
            end
          end 

      end
    end 
    puts moneda_pago 
    if moneda_pago == 1
      return ret2    
    else
      return ret1
    end 
 end 
 
 


def get_customer_payments_value_otros_moneda(fecha1,fecha2,value='factory',moneda )

    facturas = CustomerPayment.where(["fecha1 >= ? and fecha1 <= ? ", "#{fecha1} 00:00:00","#{fecha2} 23:59:59" ])        
        ret=0  
        for factura in facturas
        
          if factura.bank_acount.moneda.id == moneda   

          @detail = CustomerPaymentDetail.where(:customer_payment_id => factura.id)

          for d in @detail 
            
          
              if(value == "ajuste")


                   ret += 0
                

              elsif (value == "compen")
                ret += d.compen 
              else         
                ret += d.factory
              end
              
          end 
        end 

        end    

    return ret
 end 

end


