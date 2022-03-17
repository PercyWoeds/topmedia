class Factura < ActiveRecord::Base
  self.per_page = 20


  validates_presence_of :company_id, :code, :user_id, :medio_id 
  validates_uniqueness_of :code
  
  belongs_to :company
  belongs_to :location
  belongs_to :division
  belongs_to :contrato 
  belongs_to :payment 
  belongs_to :user
  belongs_to :moneda 
  belongs_to :medio  

  belongs_to :customer 
  belongs_to :document 
  belongs_to :tipoventa  
  
      

  has_many   :deliveryship
  has_many   :delivery 
  has_many   :invoice_services
  has_many   :factura_details 
  
   TABLE_HEADERS = ["TD",
                      "Documento",
                     "Fecha",
                     "Cliente",
                     "Moneda",
                     "",
                     "subtotal",
                     "IGV.",
                     "TOTAL",
                     ]

  TABLE_HEADERS2 = ["TD",
                     
                     "Fecha",
                    "Documento",
                     "Facturado a: ",
                    
                     "Cliente",
                     "Moneda",
                     "SUBTOTAL",
                     "IGV.",
                     "TOTAL"
                     ]

  TABLE_HEADERS3 = ["TD",
                      "Documento",
                     "Fecha",
                     "Fec.Vmto",
                     "Dias ",
                     "Cliente",
                     "Contrato",                    
                     "Moneda",                                         
                     "SOLES",
                     "DOLARES ",
                     "DETRACCION",
                     "OBSERV"]
  

  def self.search(search)
      where("code LIKE ?", "%#{search}%") 
        
  end
  
  def get_dias(id)

       a  =  Payment.find(id)

       return a.day 

  end 


  def get_tipo_cambio( fecha  )
    b = 0
    fecha1 = fecha.to_date 

     if Tipocambio.where(["dia  >= ? and dia <= ? ", "#{fecha1} 00:00:00","#{fecha1} 23:59:59" ]).exists?

      b = Tipocambio.where(["dia >= ? and dia <= ? ", "#{fecha1} 00:00:00","#{fecha1} 23:59:59" ]).last.venta 

     end 

     return b 

  end 

 
  
  def get_subtotal_items(items)
    subtotal = 0
    
    for item in items
      if(item and item != "")
        parts = item.split("|BRK|")
        
        id = parts[0]
        quantity = parts[1]
        price = parts[2]
        discount = parts[3]
        
        total = price.to_f * quantity.to_i
        total -= total * (discount.to_f / 100)
        
        begin
          product = Product.find(id.to_i)
          subtotal += total
        rescue
        end
      end
    end
    
    return subtotal
  end


  def self.to_csv(result)
    unless result.nil?
      CSV.generate do |csv|
        csv << result[0].attributes_names
        result.each do |row|
          csv << row.attributes.values
        end
      end
    end   
  end

  def self.import(file)
          CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
          Factura.create! row.to_hash 
        end
  end      

  def get_vencido

      if(self.fecha2 < Date.today)   

        return "** Vencido ** "
      else
        return ""
      end 

  end 



  def get_cancelado

      if CustomerPaymentDetail.where(factura_id: self.id).exists? 

        return "**Cancelado ** "
      else
        return ""
      end 

  end 

  def get_cancelado_datos

      if CustomerPaymentDetail.where(factura_id: self.id).exists?   

          a = CustomerPaymentDetail.where(factura_id: self.id).last 

          b = CustomerPayment.find(a.customer_payment_id)

        return b
      else
        return nil 
      end 

  end 
  

  def my_deliverys
        @deliveryships = Delivery.all 
        return @deliveryships
  end 

  def correlativo      
        numero = Voided.find(2).numero.to_i + 1
        lcnumero = numero.to_s
        Voided.where(:id=>'2').update_all(:numero =>lcnumero)        
  end


  def get_subtotal
  
    
    invoices = FacturaDetail.where(["factura_id = ? ", self.id ])
    ret = 0
    
    for invoice in invoices

        
          ret += invoice.total 
        
    end
   
    
    return ret
  end
  
  def get_tax(items, medio_id)
    tax = 0
    
    customer = Medio.find(medio_id)
    
    if(customer)
      if(customer.taxable == "1")
        for item in items
          if(item and item != "")
            parts = item.split("|BRK|")
        
            id = parts[0]
            quantity = parts[1]
            price = parts[2]
            discount = parts[3]
        
            total = price.to_f * quantity.to_f
            total -= total * (discount.to_f / 100)
        
            begin
              product = Service.find(id.to_i)
              
              if(product)
                if(product.tax1 and product.tax1 > 0)
                  tax += total * (product.tax1 / 100)
                end
                
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
    invoice_services = InvoiceService.where(factura_id: self.id)
    
    for ip in invoice_services
      ip.destroy
    end
  end
  
  def add_products(items)
    for item in items
      if(item and item != "")
        parts = item.split("|BRK|")
        
        id = parts[0]
        quantity = parts[1]
        price = parts[2]
        discount = parts[3]
        
        total = price.to_f * quantity.to_f
        total -= total * (discount.to_f / 100)
        
        begin
          product = Service.find(id.to_i)
          
 #         new_invoice_product = InvoiceService.new(:factura_id => self.id, :service_id => product.id, :price => price.to_f, :quantity => quantity.to_f, :discount => discount.to_f, :total => total.to_f)
          new_invoice_product =  FacturaDetail.new(:factura_id=> self.id ,:contrato_detail_id => 1,
            :contrato_id => 1,:service_id => product.id, :price => price.to_f,
            :quantity => quantity.to_f,:discount => discount.to_f, :total => total.to_f )            

          new_invoice_product.save

        rescue
          
        end
      end
    end
  end

  
  def add_guias(items)
    for item in items
      if(item and item != "")
        parts = item.split("|BRK|")
        
        id = parts[0]
        
        begin
          @guia = Delivery.find(id.to_i)

          @guia.processed='4'
          @guia.facturar 
          
          new_invoice_guia = Deliveryship.new(:factura_id => self.id, :delivery_id => @guia.id)          
          new_invoice_guia.save
           
        rescue
          
        end
      end
    end
  end
  

 def delete_guias()
    invoice_guias = Orden.where(factura_id: self.id)
    
    for ip in invoice_guias
      ip.processed = "1"
      ip.save
    end
  end

  def identifier
    return "#{self.code}"
  end

  def get_invoices
    @facturas= Factura.find_by_sql(['Select facturas.*,customers.ruc,payments.descrip from facturas 
      LEFT JOIN customers on facturas.customer_id = customers.id 
      LEFT JOIN payments  on facturas.payment_id = payments.id'])
      return @facturas
  end 

  def get_facturas(id)
  
    @facturas= Factura.where(["balance > 0  and customer_id = ?",  id ])

    return @facturas
  end 


  
  def get_invoices_details

  
    
  end 


  def ultimo_numero


       a= Factura.where(document_id: 2).maximum("cast(code as int)")
       if a.nil?
        return  1
      else
        return  (a + 1).to_s.rjust(6, '0') 

      end 

    
  end


  def get_products2(id)    
    @itemproducts = InvoiceService.find_by_sql(['Select invoice_services.price,
      invoice_services.quantity,invoice_services.discount,invoice_services.total,services.name 
     from invoice_services INNER JOIN services ON invoice_services.service_id = services.id where invoice_services.factura_id = ?', id ])
    
    return @itemproducts
  end

  def get_products    
    @itemproducts = InvoiceService.find_by_sql(['Select invoice_services.price,
    	invoice_services.quantity,invoice_services.discount,invoice_services.total,services.name 
  	 from invoice_services INNER JOIN services ON invoice_services.service_id = services.id where invoice_services.factura_id = ?', self.id ])
    
    return @itemproducts
  end
  
  def get_guias    
    @itemguias = Deliveryship.find_by_sql(['Select deliveries.id,deliveries.code,deliveries.description 
     from deliveryships INNER JOIN deliveries ON deliveryships.delivery_id =  deliveries.id where deliveries.remision=2 and  deliveryships.factura_id = ?', self.id ])
    return @itemguias
  end

  def get_guiasremision 
    @itemguias1 = Deliveryship.find_by_sql(['Select deliveries.code 
     from deliveryships INNER JOIN deliveries ON deliveryships.delivery_id =  deliveries.id where deliveries.remision=1 and  deliveryships.factura_id = ?', self.id ])
    return @itemguias1
  end
  def get_guias2(id)    
    @itemguias = Deliveryship.find_by_sql(['Select deliveries.id,deliveries.code,deliveries.description,deliveries.processed
     from deliveryships INNER JOIN deliveries ON deliveryships.delivery_id =  deliveries.id where deliveries.remision=2 and  deliveryships.factura_id = ?', id ])
    return @itemguias
  end

  def get_guiasremision2(id)
    @itemguias1 = Deliveryship.find_by_sql(['Select deliveries.code 
     from deliveryships INNER JOIN deliveries ON deliveryships.delivery_id =  deliveries.id where deliveries.remision=1 and  deliveryships.factura_id = ?', id ])
    return @itemguias1
  end

  def get_guias_remision(id)    
        
    guias = []
    invoice_guias = Deliverymine.where(:mine_id => id)
    return invoice_guias
        
  end
  

  def get_invoice_products
    invoice_products = InvoiceService.where(factura_id:  self.id)    
    return invoice_products
  end
  
  def products_lines
    services = []
    invoice_products = InvoiceService.where(factura_id:  self.id)
    
    invoice_products.each do | ip |

      ip.service[:price]    = ip.price
      ip.service[:quantity] = ip.quantity
      ip.service[:discount] = ip.discount
      ip.service[:total]    = ip.total
      services.push("#{ip.service.id}|BRK|#{ip.service.quantity}|BRK|#{ip.service.price}|BRK|#{ip.service.discount}")
    end
      puts  #{ip.service.id}|BRK|#{ip.service.quantity}|BRK|#{ip.service.price}|BRK|#{ip.service.discount

    return services.join(",")
  end
  
  def guias_lines
    guias = []
    invoice_guias = DeliveryShip.where(factura_id:  self.id)
    
    invoice_guias.each do | ip |
      guias.push("#{ip.delivery.id}|BRK|")
    end    

    return guias.join(",")
  end
  
    def get_processed
    if(self.processed == "1")
      return "Aprobado "

    elsif (self.processed == "2")
      
      return "**Anulado **"

    elsif (self.processed == "3")

      return "-Cerrado --"  

    elsif (self.processed == "4")

      return "-Facturado --"  

    else   
      return "No Aprobado"
        
    end
  end
  
  def get_processed_short
    if(self.processed == "1")
      return "Yes"
    elsif (self.processed == "3")
       return "Yes"
    else
      return "No"
    end
  end
  
  def get_return
    if(self.return == "1")
      return "Yes"
    else
      return "No"
    end
  end
  # Process the invoice
  def do_process
    @invoice = Factura.find(params[:id])
    @invoice[:processed] = "1"
    @invoice.process
   
    flash[:notice] = "The invoice order has been processed."
    redirect_to @invoice
  end

  def do_process2
    @invoice = Factura.find(params[:id])
    @invoice[:processed] = "1"
   # @invoice.process2
    
    flash[:notice] = "The invoice order has been processed."
    redirect_to @invoice
  end


  def cerrar
    if(self.processed == "1" )         
      
      self.processed="3"
      self.date_processed = Time.now
      self.save
    end
  end
  def do_closed
    if(self.processed == "1" )         
      
      self.processed="3"
      self.date_processed = Time.now
      self.save
    end
  end
  
  # Process the invoice
  def anular
    if(self.processed == "2" )          
      self.processed="2"
      self.subtotal =0
      self.tax = 0
      self.total = 0
      self.balance = 0
      
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
  
 def get_orden_detalle(fecha1,fecha2,moneda )
      @ordens = Orden.where(["fecha >= ? and fecha<=? and   processed = ? and moneda_id = ? ",
        "#{fecha1} 00:00:00", "#{fecha2} 23:59:59","1", moneda ]).order(:fecha)
      return @ordens

  end 

  
  def get_importe_balance_soles
       valor = 0
       if self.moneda_id ==2
          if self.document_id   == 9
                  valor = self.balance.round(2)
                    
          else  
                  valor = self.balance.round(2)
          
           end   
          end 
        return valor         
  end
  def get_importe_balance_dolares
       valor = 0
       if self.moneda_id ==1
          if self.document_id   == 9
                  valor = self.balance.round(2)
                    
          else  
                  valor = self.balance.round(2)
          
           end   
          end 
        return valor         
  end


  def get_detraccion
  
    if InvoiceService.where(factura_id: self.id ).exists?

       a = InvoiceService.where(factura_id: self.id )
     return   a.first.service.tax2 
    else
     return 0.00 
    end 
  end   
  
  def process


        #  Factura.where(id: self.id).update_all("fecha_cuota1 = fecha2, importe_cuota1 =  total - detraccion_importe ")
             @factura = Factura.find(self.id)

          puts @factura.code 

          @fecha_emision = @factura.fecha.strftime("%Y-%m-%d")
          @fecha_vmto    = @factura.fecha2.strftime("%Y-%m-%d")


          if @factura.payment.day == 0 
            @forma_pago = "CONTADO" 
            @medio_pago = "CONTADO"
          else 
             @forma_pago = "CREDITO"
             @medio_pago = "VENTA AL CREDITO"
          end



          ff = @factura.code.split("-")

          @serie  =  ff[0]
          @numero =  ff[1]

         if @factura.moneda_id == 1 
           @moneda_nube = 2
          else
                @moneda_nube = 1
          end


          if @factura.servicio == "true"
               @texto_obs = ""
          else
               @texto_obs = " "
          end

          if @factura.detraccion_importe  > 0.0
            puts " ** detraccion********************************************"


              @detraccion_tipo  =  "12"
              @detraccion_total =  @factura.detraccion_importe * @factura.tipo_cambio 
              @medio_de_pago_detraccion = "1" 
              @detraccion_porcentaje = @factura.detraccion_percent

            # create a new Invoice object
            invoice = NubeFact::Invoice.new({
                "operacion"                   => "generar_comprobante",
                "tipo_de_comprobante"               => "1",
                "serie"                             =>  @serie,
                "numero"                            =>  @numero ,
                "sunat_transaction"                 => "30",
                "cliente_tipo_de_documento"         => "6",
                "cliente_numero_de_documento"       => @factura.customer.ruc ,
                "cliente_denominacion"              => @factura.customer.name ,
                "cliente_direccion"                 => @factura.customer.direccion_all ,
                "cliente_email"                     => "",
                "cliente_email_1"                   => "",
                "cliente_email_2"                   => "",
                "fecha_de_emision"                  => @fecha_emision,
                "fecha_de_vencimiento"              => @fecha_vmto ,
                "moneda"                            => @moneda_nube,
                "tipo_de_cambio"                    => "",
                "porcentaje_de_igv"                 => "18.00",
                "descuento_global"                  => "",
                "total_descuento"                   => "",
                "total_anticipo"                    => "",
                "total_gravada"                     => @factura.subtotal,
                "total_inafecta"                    => "",
                "total_exonerada"                   => "",
                "total_igv"                         => @factura.tax,
                "total_gratuita"                    => "",
                "total_otros_cargos"                => "",
                "total"                             => @factura.total,
                "percepcion_tipo"                   => "",
                "percepcion_base_imponible"         => "",
                "total_percepcion"                  => "",
                "total_incluido_percepcion"         => "",
                "detraccion"                        => "true",
                "observaciones"                     => @texto_obs, 
                "documento_que_se_modifica_tipo"    => "",
                "documento_que_se_modifica_serie"   => "",
                "documento_que_se_modifica_numero"  => "",
                "tipo_de_nota_de_credito"           => "",
                "tipo_de_nota_de_debito"            => "",
                "enviar_automaticamente_a_la_sunat" => "true",
                "enviar_automaticamente_al_cliente" => "false",
                "codigo_unico"                      => "",
                "condiciones_de_pago"               => @forma_pago,
                "medio_de_pago"                     => @medio_pago,
                "placa_vehiculo"                    => @factura.description  ,
                "orden_compra_servicio"             => "",
                "tabla_personalizada_codigo"        => "",
                "formato_de_pdf"                    => "",
                "detraccion_tipo"                  => @detraccion_tipo,
                "detraccion_total"                 => @detraccion_total,
                "detraccion_porcentaje"            => @detraccion_porcentaje,
                "medio_de_pago_detraccion"         => @medio_de_pago_detraccion,
                "ubigeo_origen"                    => "150101",
                "direccion_origen"                 => ""
                
            })

          else 

            puts " sin detraccion**"
              # create a new Invoice object
              invoice = NubeFact::Invoice.new({
                  "operacion"                   => "generar_comprobante",
                  "tipo_de_comprobante"               => "1",
                  "serie"                             =>  @serie,
                  "numero"                            =>  @numero ,
                  "sunat_transaction"                 => "1",
                  "cliente_tipo_de_documento"         => "6",
                  "cliente_numero_de_documento"       => @factura.customer.ruc ,
                  "cliente_denominacion"              => @factura.customer.name ,
                  "cliente_direccion"                 => @factura.customer.direccion_all ,
                  "cliente_email"                     => "",
                  "cliente_email_1"                   => "",
                  "cliente_email_2"                   => "",
                  "fecha_de_emision"                  => @fecha_emision,
                  "fecha_de_vencimiento"              => @fecha_vmto ,
                  "moneda"                            => @moneda_nube,
                  "tipo_de_cambio"                    => "",
                  "porcentaje_de_igv"                 => "18.00",
                  "descuento_global"                  => "",
                  "total_descuento"                   => "",
                  "total_anticipo"                    => "",
                  "total_gravada"                     => @factura.subtotal,
                  "total_inafecta"                    => "",
                  "total_exonerada"                   => "",
                  "total_igv"                         => @factura.tax,
                  "total_gratuita"                    => "",
                  "total_otros_cargos"                => "",
                  "total"                             => @factura.total,
                  "percepcion_tipo"                   => "",
                  "percepcion_base_imponible"         => "",
                  "total_percepcion"                  => "",
                  "total_incluido_percepcion"         => "",
                  "detraccion"                        => "false",
                  "observaciones"                     => @texto_obs, 
                  "documento_que_se_modifica_tipo"    => "",
                  "documento_que_se_modifica_serie"   => "",
                  "documento_que_se_modifica_numero"  => "",
                  "tipo_de_nota_de_credito"           => "",
                  "tipo_de_nota_de_debito"            => "",
                  "enviar_automaticamente_a_la_sunat" => "true",
                  "enviar_automaticamente_al_cliente" => "false",
                  "codigo_unico"                      => "",
                  "condiciones_de_pago"               => @forma_pago,
                  "medio_de_pago"                     => @medio_pago,
                  "placa_vehiculo"                    => @factura.description  ,
                  "orden_compra_servicio"             => "",
                  "tabla_personalizada_codigo"        => "",
                  "formato_de_pdf"                    => "",
                   "detraccion_tipo"                  => "",
                   "detraccion_total"                 => "",
                   "medio_de_pago_detraccion"         => ""
                 
              })




          end    


# Add items
# You don't need to add the fields that are calculated like total or igv
# those got calculated automatically.


cantidad = 0


    
       
         @factura_detail = FacturaDetail.where(factura_id: @factura.id )
     


# for item0 in @factura_detail
#   puts "***********"
#     puts item0.product.code
#     puts item0.product.name 
#     puts item0.quantity 
#     puts item0.total 

# end

for item_factura in @factura_detail 
    

puts "*+++++++++++++++++++++"
puts item_factura.quantity  
#puts item_factura.preciosigv 

        if @factura.servicio == "true"
          invoice.add_item({
            codigo: item_factura.product.code ,
         unidad_de_medida: "ZZ", 
          descripcion: item_factura.product.name ,
          cantidad: item_factura.quantity,
          valor_unitario: item_factura.preciosigv.round(3)   ,
          tipo_de_igv: 1 

          })
        else 

          @valor_unitario = (item_factura.total / item_factura.quantity ) / 1.18 
          invoice.add_item({
            codigo: item_factura.service.code ,
           unidad_de_medida:"ZZ", 
          descripcion: item_factura.service.name ,
          cantidad: item_factura.quantity,
          valor_unitario:  @valor_unitario  ,
          tipo_de_igv: 1 

          })

        end 

end 

if @factura.importe_cuota1 > 0.00
          invoice.add_cuota({
            cuota: "1" ,
            fecha_de_pago: @factura.fecha_cuota1.strftime("%d-%m-%Y"), 
            importe: @factura.importe_cuota1 

          })

end 


if  !@factura.importe_cuota2.nil?
   if @factura.importe_cuota2 > 0.00 and 
              invoice.add_cuota({
                 cuota: "2" , 
                 fecha_de_pago: @factura.fecha_cuota2.strftime("%d-%m-%Y"), 
                 importe: @factura.importe_cuota2 


              })

    end 



else 

   
end 

if !@factura.importe_cuota3.nil?

   if @factura.importe_cuota3 > 0.00  
                invoice.add_cuota({
                   cuota: "3" ,
                  fecha_de_pago: @factura.fecha_cuota3.strftime("%d-%m-%Y"), 
                  importe: @factura.importe_cuota3 ,

                })

      end 



else 
     
end 



puts JSON.pretty_generate(invoice )

result = invoice.deliver

    if result['errors'] 
        puts  "#{result['codigo']}: #{result['errors']}  aviso"
        self.msgerror = "#{result['codigo']}: #{result['errors']}  aviso"
      else 
        self.msgerror = "Factura en nubefact."

    end

        self.processed="1"
   
        self.date_processed = Time.now
        self.save

 end

  def get_estado_nubefact

    if !self.msgerror.nil?

      return self.msgerror 
    else 
      return "-"  
    end 
      
  end 
  
end