include UsersHelper
include CustomersHelper
include ServicesHelper
require "open-uri"

class FacturasController < ApplicationController


    $: << Dir.pwd  + '/lib'
    before_action :authenticate_user!
    
    require "open-uri"

def reportes4 
    $lcFacturasall = '1'


    @company=Company.find(1)          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
   

    @current_user_id = current_user.id 
    
    @facturas_rpt = @company.get_facturas_day_todos(@fecha1,@fecha2)          
   
    
    @total1  = @company.get_facturas_by_day_value(@fecha1,@fecha2,@moneda,"subtotal")  
    @total2  = @company.get_facturas_by_day_value(@fecha1,@fecha2,@moneda,"tax")  
    @total3  = @company.get_facturas_by_day_value(@fecha1,@fecha2,@moneda,"total")  
    
    
    case params[:print]
      when "To PDF" then 
        begin 
         render  pdf: "Facturas ",template: "facturas/rventas2_rpt.pdf.erb",locals: {:facturas => @facturas_rpt},
         :orientation      => 'Landscape',
         :header => {
           :spacing => 5,
                           :html => {
                     :template => 'layouts/pdf-header.html',
                           right: '[page] of [topage]'
                  }
               }

               
        end   
      when "To Excel" then render xlsx: 'exportxls'

      else render action: "index"
    end
  end


  def discontinue
    

    @factura_id = params[:factura_id]
        puts @factura_id

        @factura = Factura.find(@factura_id)

        @facturasselect = Orden.find(params[:products_ids])
 
   
    for item in @facturasselect
        begin

      
          a = item.id
          b = item.medio_id
          c = item.customer_id 




               comision1  =  item.get_comision(item.medio_id,item.customer_id,1,@factura.tipo_factura)

               comision2  =  item.get_comision(item.medio_id,item.customer_id,2,@factura.tipo_factura)

               

              comision1_importe   =  item.total * comision1 / 100

              comision2_importe   =  ((item.total - comision1_importe) * comision2 / 100)

              puts comision1_importe
              puts comision2_importe 

              total_importe  = comision1_importe  + comision2_importe
                                
              new_invoice_detail = FacturaDetail.new(:factura_id => @factura_id  ,quantity: 1, :orden_id => a, :medio_id => b, :price=> total_importe,:total => total_importe  )          
          puts "ordennn.-++++++++++++++"
          if new_invoice_detail.save
              puts item.id 
            orden_dato = Orden.where(id: item.id).update_all(processed: "2")

          
          end 

        end              
    end

    @invoice = Factura.find(params[:factura_id])
    puts "factura ++++++++++++++++++"

    puts @invoice.get_subtotal

    @invoice[:subtotal] = @invoice.get_subtotal.round(2)
    lcTotal = @invoice[:subtotal] * 1.18
    @invoice[:total] = lcTotal.round(2)
    
    lcTax =@invoice[:total] - @invoice[:subtotal]
    @invoice[:tax] = lcTax.round(2)
    
    @invoice[:balance] = @invoice[:total]
    @invoice[:pago] = 0
    @invoice[:charge] = 0


    
    respond_to do |format|
      if @invoice.save
        # Create products for kit        
        @invoice.correlativo
                
        # Check if we gotta process the invoice
        
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully created.') }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
    
    
  end


# Process an viaticolgv
  def do_closed
    
     @company  = Company.find(1)
     @invoice =  Factura.find(params[:id])


  end
def   do_cerrar

      @invoice = Factura.find(params[:id])
  
  
      puts "do cerrar"
      importe_retencion = params[:retencion_importe].to_f
      nuevo_detraccion = params[:ac_detraccion_percent].to_f / 100 * @invoice.total 
      balance_r = 0 
       
      if @invoice.moneda == 1
           nuevo_detraccion_r = nuevo_detraccion.round(2)
          
               
      else
          nuevo_detraccion_r = nuevo_detraccion.round(0)
       
        
      end 

       balance_r = @invoice.total  - importe_retencion -  nuevo_detraccion_r

      if  @invoice.update_attributes(
      :detraccion_percent => params[:ac_detraccion_percent],
      :detraccion_importe => nuevo_detraccion_r ,
      :retencion_importe => params[:ac_retencion_importe],
      :importe_neto => balance_r, 
      :fecha_cuota1 => params[:ac_fecha_cuota1],  
      :importe_cuota1 => params[:importe_cuota1], 
      :fecha_cuota2 => params[:ac_fecha_cuota2],  
      :importe_cuota2 => params[:importe_cuota2], 
      :fecha_cuota3 => params[:ac_fecha_cuota3],  
      :importe_cuota3 => params[:importe_cuota3]       
      )

       @invoice.cerrar 
     
      
    end 


end 

  def new2
    @pagetitle = "Nueva factura"
    @action_txt = "Create"
    $lcAction="Factura"
    $Action= "create"
    @lcTipoFactura = "2"
    
    
    @invoice = Factura.new
    
     @invoice[:code] = "#{generate_guid3()}"
    
    @invoice[:processed] = false
    
    @invoice[:fecha] = Date.today
    @invoice[:orden_comision] = "3"

    
    
    @company = Company.find(params[:company_id])
    @invoice.company_id = @company.id
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @payments = @company.get_payments()
    @services = @company.get_services()
    @products = @company.get_products()
    @medios = @company.get_medios()
    @contratos = Contrato.all.order(:code )

    @deliveryships = @invoice.my_deliverys 
    @tipofacturas = @company.get_tipofacturas() 
    @monedas = @company.get_monedas()
    @tipodocumento = @company.get_documents()

    @ac_user = getUsername()
    @invoice[:user_id] = getUserId()
    @invoice[:moneda_id] = 2
    @invoice[:document_id] = 2  
    @invoice[:contrato_id] = 1 
    @invoice[:payment_id] = 2 
    
    
    
  end


  def rpt_facturas_xls

    @company=Company.find(1)          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]

    @facturas_rpt = @company.get_facturas_day(@fecha1,@fecha2)      

    respond_to do |format|
      format.html    
        format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end 
  end 

  def import
      Factura.import(params[:file])
       redirect_to root_url, notice: "Factura importadas."
  end 


    # Export invoice to PDF
  def pdf
    @invoice = Factura.find(params[:id])
    respond_to do |format|
      format.html { redirect_to("/facturas/pdf/#{@invoice.id}.pdf") }
      format.pdf { render :layout => false }
    end
  end
  
  # Process an invoice
  def do_process
    @invoice = Factura.find(params[:id])
    @invoice[:processed] = "1"
    @invoice.process
    
    flash[:notice] = "The invoice order has been processed."
    redirect_to @invoice
  end
  
  # Do send invoice via email
  def do_email
    @invoice = Factura.find(params[:id])
    @email = params[:email]
    
    Notifier.invoice(@email, @invoice).deliver
    
    flash[:notice] = "The invoice has been sent successfully."
    redirect_to "/facturas/#{@invoice.id}"
  end
  
  # Send invoice via email
  def email
    @invoice = Factura.find(params[:id])
    @company = @invoice.company
  end

  def do_anular
    @invoice = Factura.find(params[:id])
    @invoice[:processed] = "2"
    
    @invoice.anular 
    @invoice.delete_guias()
  
    flash[:notice] = "Documento a sido anulado."
    redirect_to @invoice 
  end
  
  
    

  
  # List items
  def list_items
    
    @company = Company.find(params[:company_id])
    items = params[:items]
    items = items.split(",")
    items_arr = []
    @products = []
    i = 0

    for item in items
      if item != ""
        parts = item.split("|BRK|")
        
        id = parts[0]
        quantity = parts[1]
        price = parts[2]
        discount = parts[3]
        
        product = Service.find(id.to_i)
        product[:i] = i
        product[:quantity] = quantity.to_f
        product[:price] = price.to_f
        product[:discount] = discount.to_f
        
        total = product[:price] * product[:quantity]
        total -= total * (product[:discount] / 100)
        
        product[:currtotal] = total
        
        @products.push(product)
      end
      
      i += 1
   end
    
    render :layout => false
  end
  
  def list_items2
    
    @company = Company.find(params[:company_id])
    items = params[:items2]
    items = items.split(",")
    items_arr = []
    @guias = []
    i = 0

    for item in items
      if item != ""
        parts = item.split("|BRK|")

        puts parts

        id = parts[0]      
        product = Delivery.find(id.to_i)
        product[:i] = i

        @guias.push(product)


      end
      
      i += 1
    end

    render :layout => false
  end 
  # Autocomplete for products
  def ac_guias
    procesado='4'

    @guias = Delivery.where(["company_id = ? AND (code LIKE ?)", params[:company_id], "%" + params[:q] + "%"])   
    render :layout => false
  end
  
  # Autocomplete for products
  def ac_services
    @products = Service.where(["company_id = ? AND (code LIKE ? OR name LIKE ?)", params[:company_id], "%" + params[:q] + "%", "%" + params[:q] + "%"])
   
    render :layout => false
  end
  
  # Autocomplete for users
  def ac_user
    company_users = CompanyUser.where(company_id: params[:company_id])
    user_ids = []
    
    for cu in company_users
      user_ids.push(cu.user_id)
    end
    
    @users = User.where(["id IN (#{user_ids.join(",")}) AND (email LIKE ? OR username LIKE ?)", "%" + params[:q] + "%", "%" + params[:q] + "%"])
    alr_ids = []
    
    for user in @users
      alr_ids.push(user.id)
    end
    
    if(not alr_ids.include?(getUserId()))
      @users.push(current_user)
    end
   
    render :layout => false
  end
  
  # Autocomplete for customers
  def ac_customers
    @customers = Customer.where(["company_id = ? AND (ruc iLIKE ? OR name iLIKE ?)", params[:company_id], "%" + params[:q] + "%", "%" + params[:q] + "%"])
   
    render :layout => false
  end
   def ac_contrato_cuotas
    
     @contrato_cuotas = ContratoDetail.where(:contrato_id =>[ params[:q] + "%" ]) 
    
  
    render :layout => false
  end

  def ac_contratos
     @contratos = Contrato.find_by_sql(['Select medios.descrip,customers.name as name,contratos.code,contratos.id  
     from contratos 
     INNER JOIN customers ON contratos.customer_id = customers.id
     INNER JOIN medios on contratos.medio_id = medios.id 
     WHERE contratos.code like  ?  ',"%" + params[:q] + "%" ]) 
  
    render :layout => false
  end
  

  # Show invoices for a company
  def list_invoices
    @company = Company.find(params[:company_id])
    @pagetitle = "#{@company.name} - Invoices"
    @filters_display = "block"
    
    @locations = Location.where(company_id: @company.id).order("name ASC")
    @divisions = Division.where(company_id: @company.id).order("name ASC")
    
    if(params[:location] and params[:location] != "")
      @sel_location = params[:location]
    end
    
    if(params[:division] and params[:division] != "")
      @sel_division = params[:division]
    end
  
    if(@company.can_view(current_user))

         @invoices = Factura.all.order('id DESC').paginate(:page => params[:page])
        if params[:search]
          @invoices = Factura.search(params[:search]).order('id DESC').paginate(:page => params[:page])
        else
          @invoices = Factura.all.order('id DESC').paginate(:page => params[:page]) 
        end

    
    else
      errPerms()
    end
  end
  
  # GET /invoices
  # GET /invoices.xml
  def index
    @companies = Company.where(user_id: current_user.id).order("name")
    @path = 'factura'
    @pagetitle = "Facturas"

    @invoicesunat = Invoicesunat.order(:numero)    

    @company= Company.find(1)

  end

  def export
    @company = Company.find(params[:company_id])
    @facturas  = Factura.all
  end
  def export3
    @company = Company.find(params[:company_id])
    @facturas  = Factura.all
  end
  def export4
    @company = Company.find(params[:company_id])
    @facturas  = Factura.all
  end
  

  def newfactura2
    

    @company = Company.find(1)
    @factura = Factura.find(params[:factura_id])
    @medio = @factura.medio
    @customer = @factura.customer 


     @mes = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]
    
    
    @customers =  @company.get_customers()     

    @factura_detail = Factura.new

  



    if !@medio.nil?
   @medio_name = @medio.descrip
   puts "mmedio"
    puts @medio.id

      @detalleitems =  Orden.where("month >= ? and year >= ? and month <= ? and year <= ?and processed=? and medio_id =? and customer_id = ? and moneda_id = ? and facturado is null",
          "#{@mes}","#{@anio}", "#{@mes1}","#{@anio1}","1",@medio.id,@customer.id,@factura.moneda_id ).order(:fecha) 
     
    else
    @detalleitems =  Orden.where("month >= ? and year >= ? and month <= ? and year <= ?  and processed=?  and customer_id = ? and moneda_id = ? and facturado is null",
          "#{@mes}","#{@anio}", "#{@mes1}","#{@anio1}","1",@customer.id,@factura.moneda_id ).order(:fecha) 
      
     

    end 




  
  end 



  def generar4
    
    @company = Company.find(params[:company_id])
     Csubdiario.delete_all
     Dsubdiario.delete_all


     fecha1 =params[:fecha1]
     fecha2 =params[:fecha2]

     @facturas = @company.get_facturas_day(fecha1,fecha2)

      $lcSubdiario='05'

      subdiario = Numera.find_by(:subdiario=>'12')

      lastcompro = subdiario.compro.to_i + 1
      $lastcompro1 = lastcompro.to_s.rjust(4, '0')

        item = fecha1.to_s 
        parts = item.split("-")        
        
        mm    = parts[1]        

      if subdiario
          nrocompro = mm << $lastcompro1
      end


     for f in @facturas
        
        $lcFecha =f.fecha.strftime("%Y-%m-%d")   
        


      newsubdia =Csubdiario.new(:csubdia=>$lcSubdiario,:ccompro=>$lastcompro1,:cfeccom=>$lcFecha, :ccodmon=>"MN",
        :csitua=>"F",:ctipcam=>"0.00",:cglosa=>f.code,:csubtotal=>f.subtotal,:ctax=>f.tax,:ctotal=>f.total,
        :ctipo=>"V",:cflag=>"N",:cdate=>$lcFecha ,:chora=>"",:cfeccam=>"",:cuser=>"SIST",
        :corig=>"",:cform=>"M",:cextor=>"",:ccodane=>f.customer.ruc ) 

        newsubdia.save

      lastcompro = lastcompro + 1
      $lastcompro1 = lastcompro.to_s.rjust(4, '0')      

      end 

      subdiario.compro = $lastcompro1
      subdiario.save

      @invoice = Csubdiario.all
      send_data @invoice.to_csv  , :filename => 'CC0317.csv'

    
  end

  def generar5

      option =  params[:archivo]
      puts option

      if option == "Ventas Cabecera"

        @invoice = Csubdiario.all
        send_data @invoice.to_csv  , :filename => 'CC0317.csv'

      else
        @invoice = Dsubdiario.all
        send_data @invoice.to_csv  , :filename => 'CD0317.csv'

        
      end 
       
  end 

  def export2
    Invoicesunat.delete_all

    @company = Company.find(params[:company_id])
    @facturas  = Factura.where(:tipo => 1)
     a = ""
     
     lcGuia=""
    for f in @facturas      
        @fec =(f.code)
        parts = @fec.split("-")
        lcSerie  = parts[0]
        lcNumero = parts[1]
        lcFecha  = f.fecha 
        lcTD = "FT"
        lcVventa = f.subtotal
        lcIGV = f.tax
        lcImporte = f.total 
        lcFormapago = f.payment.descrip
        lcRuc = f.customer.ruc         
        lcDes = f.description
        lcMoneda = f.moneda_id 
              
        for productItem in f.get_products2(f.id)

        lcPsigv= productItem.price
        lcPsigv1= lcPsigv*1.18
        lcPcigv = lcPsigv1.round(2)
        lcCantidad= productItem.quantity
        lcDescrip = ""

        lcDescrip << productItem.name + "\n"

        lcDescrip << lcDes

        a = ""        
        lcDes1 = ""

        begin

          a << " GT: "

            for guia in f.get_guias2(f.id)

              a <<  guia.code << " "
              if guia.description == nil
                
              else  


                  a << " " << guia.description                   


              end   
              existe1 = f.get_guias_remision(guia.id)

              if existe1.size > 0 
                a<<  "\n GR:" 
                for guias in  f.get_guias_remision(guia.id)    
                   a<< guias.delivery.code<< ", " 
                end     
              end      

            end
              existe2 = f.get_guiasremision2(f.id)
              if existe2.size > 0
              a << "\n GR : "
                for guia in f.get_guiasremision2(f.id)
                  a << guia.code << " "            
                end
              end 

            lcDes1 << a
            lcComments = ""
          
        end
new_invoice_item= Invoicesunat.new(:cliente => lcRuc, :fecha => lcFecha,:td=>lcTD,
:serie=>lcSerie,:numero=>lcNumero,:preciocigv => lcPcigv ,:preciosigv=>lcPsigv,:cantidad=>lcCantidad,
:vventa=>lcVventa,:igv=>lcIGV,:importe => lcImporte,:ruc=>lcRuc,:guia=> lcGuia,:formapago=>lcFormapago,
:description=>lcDescrip,:comments=> lcComments,:descrip=>lcDes1,:moneda=>lcMoneda )
new_invoice_item.save

       end  
    end 

  
    @invoice = Invoicesunat.all
    send_data @invoice.to_csv  
    
  end
  
  def generar
        
    @company = Company.find(params[:company_id])
    @users = @company.get_users()
    @users_cats = []
    
    @pagetitle = "Generar archivo txt"
    
    @f =(params[:fecha1])

        parts = @f.split("-")
        yy = parts[0]
        mm = parts[1]
        dd = parts[2]

     @fechadoc=dd+"/"+mm+"/"+yy   
     @tipodocumento='01'
    
    files_to_clean =  Dir.glob("./app/txt_output/*.txt")
        files_to_clean.each do |file|
          File.delete(file)
        end 
  

    @facturas_all_txt = @company.get_facturas_year_month_day(@f)



    if @facturas_all_txt
      out_file = File.new("#{Dir.pwd}/app/txt_output/20424092941-RF-#{dd}#{mm}#{yy}-01.txt", "w")      
        for factura in @facturas_all_txt 
            parts = factura.code.split("-")
            @serie     =parts[0]
            @nrodocumento=parts[1]

            out_file.puts("7|#{@fechadoc}|#{@tipodocumento}|#{@serie}|#{@nrodocumento}||6|#{factura.customer.ruc}|#{factura.customer.name}|#{factura.subtotal}|0.00|0.00|0.00|#{factura.tax}|0.00|#{factura.total}||||\n")
                    
        end 
    out_file.close
    end 
    
    
  end

  def generar3
        
    @company = Company.find(params[:company_id])
    @users = @company.get_users()
    @users_cats = []
    
    @pagetitle = "Generar archivo"
    
    @f =(params[:fecha1])
    @f2 =(params[:fecha1])

        parts = @f.split("-")
        yy = parts[0]
        mm = parts[1]
        dd = parts[2]

     @fechadoc=dd+"/"+mm+"/"+yy   
     @tipodocumento='01'
    
    files_to_clean =  Dir.glob("./app/txt_output/*.txt")
        files_to_clean.each do |file|
          File.delete(file)
        end 

    @facturas_all_txt = @company.get_facturas_year_month_day2(@f,@f2)

    if @facturas_all_txt
      out_file = File.new("#{Dir.pwd}/app/txt_output/20424092941-RF-#{dd}#{mm}#{yy}-01.txt", "w")      
        for factura in @facturas_all_txt 
            parts = factura.code.split("-")
            @serie     =parts[0]
            @nrodocumento=parts[1]

            out_file.puts("7|#{@fechadoc}|#{@tipodocumento}|#{@serie}|#{@nrodocumento}||6|#{factura.customer.ruc}|#{factura.customer.name}|#{factura.subtotal}|0.00|0.00|0.00|#{factura.tax}|0.00|#{factura.total}||||\n")
                    
        end 
    out_file.close
    end 
        
  end    

  # GET /invoices/1
  # GET /invoices/1.xml
  def show
    @company = Company.find(1)

    @invoice = Factura.find(params[:id])
    @contrato = @invoice.contrato 
    @invoice_details = @invoice.factura_details 
    @medio  = @invoice.medio 
    @customer = @invoice.customer 

    @medios = @company.get_medios()
    @customers = @company.get_customers()

    @productos = @company.get_products()



     if(params[:year] and params[:year].numeric?)
      @year = params[:year].to_i
    else
      @year = 2022
    end

    if(params[:month] and params[:month].numeric?)
      @month = params[:month].to_i
    else
      @month = Time.now.month
    end

    if(@month < 10)
      month_s = "0#{@month}"
    else
      month_s = @month.to_s
    end

    curr_year = Time.now.year + 1 
    c_year = curr_year
    c_month = 1

    @years = []
    @months = monthsArr
    @month_name = @months[@month - 1][0]



    while(c_year > 2022  - 5)
      @years.push(c_year)
      c_year -= 1
    end



     respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invoice  }
    end
    
    
    
  end

  # GET /invoices/new
  # GET /invoices/new.xml
  
  def new
    @pagetitle = "Nueva factura"
    @action_txt = "Create"
    
    @invoice = Factura.new
    @invoice[:code] = "#{generate_guid3()}"
    @invoice[:processed] = false
     @invoice[:fecha]  = Date.today  
     @invoice[:orden_comision] = "1"

    @company = Company.find(params[:company_id])
    @invoice.company_id = @company.id
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @payments = @company.get_payments()
    @services = @company.get_services()
    @deliveryships = @invoice.my_deliverys 
    @tipofacturas = @company.get_tipofacturas() 
    @monedas = @company.get_monedas()
    @medios = @company.get_medios()
    @customers = @company.get_customers()
    
    @tipodocumento = @company.get_documents()

    @ac_user = getUsername()
    @invoice[:user_id] = getUserId()

    @lcTipoFactura = "1"

    @invoice[:description]  = "SERVICIO DE GESTION PUBLICITARIA"
  end

 def new3
    @pagetitle = "Nueva factura"
    @action_txt = "Create"
    
    @invoice = Factura.new
    @invoice[:code] = "#{generate_guid3()}"
    @invoice[:processed] = false
    @invoice[:fecha]  = Date.today 
    @invoice[:orden_comision] = "2"

    @company = Company.find(params[:company_id])
    @invoice.company_id = @company.id
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @payments = @company.get_payments()
    @services = @company.get_services()
    @deliveryships = @invoice.my_deliverys 
    @tipofacturas = @company.get_tipofacturas() 
    @monedas = @company.get_monedas()
    @medios = @company.get_medios()
    @customers = @company.get_customers()
    
    @tipodocumento = @company.get_documents()

    @ac_user = getUsername()
    @invoice[:user_id] = getUserId()

    @lcTipoFactura = "1"

    @invoice[:description]  = "SERVICIO DE GESTION PUBLICITARIA"
  end

  # GET /invoices/1/edit
  def edit
    @pagetitle = "Edit invoice"
    @action_txt = "Update"
    
    @invoice = Factura.find(params[:id])


  @company = Company.find(1)
    @invoice.company_id = @company.id
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @payments = @company.get_payments()
    @services = @company.get_services()
    @deliveryships = @invoice.my_deliverys 
    @tipofacturas = @company.get_tipofacturas() 
    @monedas = @company.get_monedas()
    @medios = @company.get_medios()
    @tipodocumento = @company.get_documents()

    @ac_user = getUsername()
    @invoice[:user_id] = getUserId()

    @lcTipoFactura = "1"

  end

  # POST /invoices
  # POST /invoices.xml
  def create
    @pagetitle = "Nueva factura "
    @action_txt = "Create"
   
  
    items = params[:items].split(",")

    items2 = params[:items2].split(",")

    @invoice = Factura.new(factura_params)
    
    @company = Company.find(params[:factura][:company_id])
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @payments = @company.get_payments()    
    @services = @company.get_services()
    @tipofacturas = @company.get_tipofacturas() 
    @monedas = @company.get_monedas()
    @medios = @company.get_medios()
    @customers = @company.get_customers()
   
    @tipodocumento = @company.get_documents()

    @invoice[:subtotal] = 0
    
    begin

      @invoice[:tax] = 0
    rescue
      @invoice[:tax] = 0
    end
    

    @invoice[:total] = @invoice[:subtotal] + @invoice[:tax]
    @invoice[:balance] = @invoice[:total]
    @invoice[:pago] = 0
    @invoice[:charge] = 0
    @invoice[:tipo] = 1
        
    @invoice[:location_id] = 1
    @invoice[:division_id] = 1
    @invoice[:tc] = @lcTipoFactura 
  # contrato generico sino no hay contrato 
    if @invoice[:contrato_id] == nil
      @invoice[:contrato_id] = 1449 
    end 
  

   @invoice[:code] = @invoice.get_maximo(params[:option],params[:factura][:document_id])

   
    
    if items != nil or items !=""

      @invoice[:subtotal] = @invoice.get_subtotal_items(items)
      
      begin
        @invoice[:tax] = @invoice.get_tax(items, @invoice[:medio_id])
      rescue
        @invoice[:tax] = 0
      end
      
      @invoice[:total] = @invoice[:subtotal] + @invoice[:tax]
      

    end 
    
    if(params[:factura][:user_id] and params[:factura][:user_id] != "")
      curr_seller = User.find(params[:factura][:user_id])
      @ac_user = curr_seller.username
    end
  
   days = @invoice.get_dias(params[:factura][:payment_id])
    @invoice[:fecha2] = @invoice[:fecha] + days.days   

    @invoice[:cuota1] = 1
    @invoice[:cuota2] = 2
    @invoice[:cuota3] = 3
    @invoice[:cuota2] = 4
    @invoice[:cuota3] = 5

    @invoice[:detraccion_cuenta]  =   "00-000-5353302" 
    @invoice[:detraccion_percent] = 0
    @invoice[:detraccion_importe] = 0
    @invoice[:retencion_importe]  = 0

    @invoice[:fecha_cuota1] = @invoice[:fecha2]
    @invoice[:importe_cuota1] = @invoice[:total] - @invoice[:detraccion_importe]

    @invoice[:fecha_cuota2] = @invoice[:fecha_cuota1] - days.days 
    @invoice[:fecha_cuota3] = @invoice[:fecha_cuota2] - days.days  

    @invoice[:fecha_cuota4] = @invoice[:fecha_cuota3] - days.days 
    @invoice[:fecha_cuota5] = @invoice[:fecha_cuota4] - days.days  

    @invoice[:importe_cuota1] = 0
    @invoice[:importe_cuota2] = 0
    @invoice[:importe_cuota3] = 0
    @invoice[:importe_cuota4] = 0
    @invoice[:importe_cuota5] = 0

    @invoice[:tipo_cambio] = @invoice.get_tipo_cambio(@invoice.fecha)





    respond_to do |format|

      if @invoice.save

        # Create products for kit
        if items !=  nil or items != ""
         @invoice.add_products(items)
        end 
        @invoice.correlativo
        # Check if we gotta process the invoice
       # @invoice.process()
        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully created.') }
        format.xml  { render :xml => @invoice, :status => :created, :location => @invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /invoices/1
  # PUT /invoices/1.xml
  def update
    @pagetitle = "Edit invoice"
    @action_txt = "Update"
    
    items = params[:items].split(",")
    
    @invoice = Factura.find(params[:id])
    @company = @invoice.company
    @payments = @company.get_payments()    
     @medios = @company.get_medios()
   @tipofacturas = @company.get_tipofacturas() 
    if(params[:ac_customer] and params[:ac_customer] != "")
      @ac_customer = params[:ac_customer]
    else
      @ac_customer = @invoice.customer.name
    end
    
    @products_lines = @invoice.products_lines
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    
    @invoice[:subtotal] = @invoice.get_subtotal(items)
    @invoice[:tax] = @invoice.get_tax(items, @invoice[:medio_id])
    @invoice[:total] = @invoice[:subtotal] + @invoice[:tax]

    respond_to do |format|
      if @invoice.update_attributes(factura_params)
        # Create products for kit
        @invoice.delete_products()
        @invoice.add_products(items)
        @invoice.correlativo
        # Check if we gotta process the invoice
        @invoice.process()
         


        format.html { redirect_to(@invoice, :notice => 'Invoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.xml
  def destroy
    @invoice = Factura.find(params[:id])


    company_id = @invoice[:company_id]
    if @invoice.destroy
      @invoice.delete_guias()
    end   


    respond_to do |format|
      format.html { redirect_to("/companies/facturas/" + company_id.to_s) }
    end

  end


# reporte completo
  def build_pdf_header_rpt(pdf)
      pdf.font "Helvetica" , :size => 8


     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers_rpt.length, invoice_headers_rpt.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers_rpt.length >= row ? client_data_headers_rpt[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers_rpt.length >= row ? invoice_headers_rpt[rows_index] : ['',''])
      end

      if rows.present?

        pdf.table(rows, {
          :position => :center,
          :cell_style => {:border_width => 0},
          :width => pdf.bounds.width
        }) do
          columns([0, 2]).font_style = :bold

        end

        pdf.move_down 10

      end
    
      pdf 
  end   

  def build_pdf_body_rpt(pdf)
    
    pdf.text "Facturas " +" Emitidas : desde "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 


    pdf.text ""
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Factura::TABLE_HEADERS2.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

      lcDoc='FT'
      @moneda = "1"
     

     puts 
       for  product in @facturas_rpt_1

            row = []          
            row << product.document.descripshort
            row << product.fecha.strftime("%d/%m/%Y")            
            row << product.code
            row << product.medio.descrip 
            if product.tc == "1"
              row << product.contrato.medio.descrip  
            else 
              row << ""
            end 

            if product.moneda_id == 1
              row << "USD"
            else
              row << "S/."
            end 

            row << money(product.subtotal)
            row << money(product.tax)
            row << money(product.total)
                        
            table_content << row

            nroitem=nroitem + 1
       
        end



      subtotals = []
      taxes = []
      totals = []
      services_subtotal = 0
      services_tax = 0
      services_total = 0

    if $lcFacturasall == '1'   

      subtotal = @company.get_facturas_day_value(@fecha1,@fecha2, "subtotal",@moneda)
      subtotals.push(subtotal)
      services_subtotal += subtotal          
      #pdf.text subtotal.to_s
    
    
      tax = @company.get_facturas_day_value(@fecha1,@fecha2, "tax",@moneda)
      taxes.push(tax)
      services_tax += tax
    
      #pdf.text tax.to_s
      
      total = @company.get_facturas_day_value(@fecha1,@fecha2, "total",@moneda)
      totals.push(total)
      services_total += total
      #pdf.text total.to_s

    else
        #total x cliente 
      subtotal = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "subtotal")
      subtotals.push(subtotal)
      services_subtotal += subtotal          
      #pdf.text subtotal.to_s
    
    
      tax = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "tax")
      taxes.push(tax)
      services_tax += tax
    
      #pdf.text tax.to_s
      
      total = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "total")
      totals.push(total)
      services_total += total
    
    end

      row =[]
      row << ""
      row << ""
      row << ""
      row << "TOTALES => "
      row << ""
      row << ""
      
       row << money(services_subtotal)
      row << money(services_tax)
      row << money(services_total)

      
      table_content << row


       @moneda = "2"


       for  product in @facturas_rpt_2

            row = []          
            row << lcDoc
            row << product.fecha.strftime("%d/%m/%Y")            
            row << product.code
            row << product.medio.descrip 
            if product.tc == "1"
              row << product.contrato.customer.name  
            else 
              row << ""
            end 

            if product.moneda_id == 1
              row << "USD"
            else
              row << "S/."
            end 

            row << money(product.subtotal)
            row << money(product.tax)
            row << money(product.total)
                        
            table_content << row

            nroitem=nroitem + 1
       
        end



      subtotals = []
      taxes = []
      totals = []
      services_subtotal = 0
      services_tax = 0
      services_total = 0

    if $lcFacturasall == '1'    
      subtotal = @company.get_facturas_day_value(@fecha1,@fecha2, "subtotal",@moneda)
      subtotals.push(subtotal)
      services_subtotal += subtotal          
      #pdf.text subtotal.to_s
    
    
      tax = @company.get_facturas_day_value(@fecha1,@fecha2, "tax",@moneda)
      taxes.push(tax)
      services_tax += tax
    
      #pdf.text tax.to_s
      
      total = @company.get_facturas_day_value(@fecha1,@fecha2, "total",@moneda)
      totals.push(total)
      services_total += total
      #pdf.text total.to_s

    else
        #total x cliente 
      subtotal = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "subtotal")
      subtotals.push(subtotal)
      services_subtotal += subtotal          
      #pdf.text subtotal.to_s
    
    
      tax = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "tax")
      taxes.push(tax)
      services_tax += tax
    
      #pdf.text tax.to_s
      
      total = @company.get_facturas_day_value_cliente(@fecha1,@fecha2,@cliente, "total")
      totals.push(total)
      services_total += total
    
    end

      row =[]
      row << ""
      row << ""
      row << ""
      row << "TOTALES => "
      row << ""
      row << ""
      
      row << money(services_subtotal)
      row << money(services_tax)
      row << money(services_total)
      
      table_content << row



      
      result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width
                                        } do 
                                          columns([0]).align=:center
                                          columns([1]).align=:left
                                          columns([2]).align=:left
                                          columns([3]).align=:left
                                          columns([4]).align=:left
                                          columns([5]).align=:right  
                                          columns([6]).align=:right
                                          columns([7]).align=:right
                                          columns([8]).align=:right
                                        end                                          
      pdf.move_down 10      

      #totales 

      pdf 
    end

    def build_pdf_footer_rpt(pdf)
      
                  
      pdf.text "" 
      pdf.bounding_box([0, 20], :width => 535, :height => 40) do
      pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end

##### reporte de pendientes de pago..

  def build_pdf_header_rpt2(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers_rpt.length, invoice_headers_rpt.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers_rpt.length >= row ? client_data_headers_rpt[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers_rpt.length >= row ? invoice_headers_rpt[rows_index] : ['',''])
      end

      if rows.present?

        pdf.table(rows, {
          :position => :center,
          :cell_style => {:border_width => 0},
          :width => pdf.bounds.width
        }) do
          columns([0, 2]).font_style = :bold

        end

        pdf.move_down 10

      end


      
      pdf 
  end   


  def build_pdf_header_rpt2(pdf)
    
       pdf.font "Helvetica"  , :size => 8

     image_path = "#{Dir.pwd}/public/images/logo3.jpg"
      
       table_content = ([ [{:image => image_path, :rowspan => 3 , position: :center, vposition: :center}, 
        {:content =>"SISTEMA DE GESTIÓN INTEGRADO",:rowspan => 2, :valign => :center },"CODIGO ","TP-FZ-F-035"], 
          ["VERSION: ","1"], 
          ["ESTADO DE CUENTAS POR COBRAR - CLIENTES ","Pagina: ","1 de 1 "] 
         
          ])
    


       pdf.table(table_content  ,{
           :position => :center,
           :width => pdf.bounds.width
         })do
           columns([1,2]).font_style = :bold
            columns([0]).width = 118.55
            columns([1]).width = 261.45
            columns([1]).align = :center
            columns([3]).align = :center
            
            columns([2]).width = 80
          
            columns([3]).width = 80
      
         end
        
      
          table_content2 = ([["Fecha : ",Date.today.strftime("%d/%m/%Y")]])

         pdf.table(table_content2,{:position=>:right }) do

            columns([0, 1]).font_style = :bold
            columns([0, 1]).width = 80
            
         end 

     
        pdf.text "Cuentas por cobrar  : Desde "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 
    pdf.text ""
         
         pdf.move_down 2
      
    
      
      pdf 
  end   

  def build_pdf_body_rpt2(pdf)
    
    
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Factura::TABLE_HEADERS3.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem = 1
      lcmonedasoles   = 2
      lcmonedadolares = 1
  
     
      @totalvencido_soles = 0
      @totalvencido_dolar = 0
      total_soles = 0
      total_dolares = 0 
      lcDoc = "FT"
      
       for  detalle in @facturas_rpt



             @cliente_detalle =   @company.get_pendientes_day_cliente2(@fecha1,@fecha2,detalle.medio_id) 

              total_cliente_soles = 0

              total_cliente_dolares = 0




          for product in @cliente_detalle 

              if product.document_id == 2
                  balance_importe = product.balance.round(2) * -1
              else
                  balance_importe = product.balance.round(2) 
              end 
           
         
             if balance_importe != 0.00
            
                fechas2 = product.fecha2 

                row = []          
                if product.document 
                  row << product.document.descripshort 
                else
                  row <<  lcDoc 
                end 
                row << product.code
                row << product.fecha.strftime("%d/%m/%Y")
                row << product.fecha2.strftime("%d/%m/%Y")
                dias = (product.fecha2.to_date - product.fecha.to_date).to_i 
                row << dias 
                row << product.medio.descrip 
                row << ""             
                row << product.moneda.symbol  

                if product.moneda_id == 1 
                      row << "0.00 "
                      row << sprintf("%.2f",product.balance.to_s)
                      if(product.fecha2 < Date.today)   
                          @totalvencido_dolar += product.balance.round(2)
                      end  
                      total_cliente_dolares += balance_importe
                else
                      row << sprintf("%.2f",product.balance.to_s)
                      row << "0.00 "
                      if(product.fecha2 < Date.today)   
                          @totalvencido_soles += product.balance.round(2)
                      end  
                      total_cliente_soles   += balance_importe
                    
                end
                
                
                if product.detraccion == nil
                  row <<  "0.00"
                else  
                  row << sprintf("%.2f",product.detraccion.to_s)
                end
                row << product.get_vencido 

                table_content << row

                nroitem = nroitem + 1
                
              end 


        end 

          if (total_cliente_soles != 0 || total_cliente_dolares != 0 )    

            row =[]
            row << ""
            row << ""
            row << ""
            row << ""  
            row << "" 
           
            row << "TOTALES POR MEDIO  => "            
            row << ""
            row << "" 
            row << sprintf("%.2f",total_cliente_soles.to_s)
            row << sprintf("%.2f",total_cliente_dolares.to_s)
           
            row << " "
            row << " "
            
            table_content << row



            total_soles += total_cliente_soles.round(2)
            total_dolares += total_cliente_dolares.round(2)

          end 

        end

                
        
           if $lcxCliente == "0" 

          row =[]
          row << ""
          row << ""
          row << ""
          row << ""
          row << ""  
          row << "TOTALES => "
          row << ""
            row << ""
          row << sprintf("%.2f",total_soles.to_s)
          row << sprintf("%.2f",total_dolares.to_s)                    
          row << " "
          row << " "
          
          table_content << row
          end 
          



          result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width
                                        } do 
                                          columns([0]).align=:center
                                          columns([1]).align=:left
                                          columns([2]).align=:left
                                          columns([3]).align=:left
                                          columns([4]).align=:left
                                          columns([5]).align=:left   
                                          columns([5]).width = 100 
                                          columns([6]).align=:right
                                           columns([6]).width = 50
                                          columns([7]).align=:right
                                          columns([8]).align=:right
                                          columns([9]).align=:right
                                          columns([10]).align=:right
                                        end                                          
                                        
      pdf.move_down 10    
      
      
      
      if $lcxCliente == "1" 
      
      totalxvencer_soles  = total_cliente_soles   - @totalvencido_soles
      totalxvencer_dolar  = total_cliente_dolares - @totalvencido_dolar
      
      pdf.table([  ["Resumen    "," Soles  ", "Dólares "],
              ["Total Vencido    ",sprintf("%.2f",@totalvencido_soles.to_s), sprintf("%.2f",@totalvencido_dolar.to_s)],
              ["Total por Vencer ",sprintf("%.2f",totalxvencer_soles.to_s),sprintf("%.2f",totalxvencer_dolar.to_s)],
              ["Totales          ",sprintf("%.2f",total_cliente_soles.to_s),sprintf("%.2f",total_cliente_dolares.to_s)]])
              
      end 
      #totales 
      
      pdf 

    end

    def build_pdf_footer_rpt2(pdf)      
                  
      pdf.text "" 
      pdf.bounding_box([0, 20], :width => 535, :height => 40) do
      pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

    end

    pdf
      
  end


  # Export serviceorder to PDF
  def rpt_facturas_all_pdf 

    $lcFacturasall = '1'
  puts params[:company_id]

    @company=Company.find(params[:company_id]) 

    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
  

    @facturas_rpt_1 = @company.get_facturas_day(@fecha1,@fecha2,"1")      
    @facturas_rpt_2 = @company.get_facturas_day(@fecha1,@fecha2,"2")      

 case params[:print]


      when "To PDF" then 
            $lcxCliente ="0"
            @company=Company.find(1)      
            @fecha1 = params[:fecha1]    
            @fecha2 = params[:fecha2]

            lcmonedadolares ="1"
            lcmonedasoles ="2"
          
            @company.actualizar_fecha2
            @facturas_rpt = @company.get_pendientes_day_cliente1(@fecha1,@fecha2)  

              
            Prawn::Document.generate("app/pdf_output/rpt_factura.pdf") do |pdf|
              pdf.font "Helvetica"
              pdf = build_pdf_header_rpt(pdf)
              pdf = build_pdf_body_rpt(pdf)
              build_pdf_footer_rpt(pdf)


              $lcFileName =  "app/pdf_output/rpt_factura_all.pdf"              
          end     


          $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
          send_file("app/pdf_output/rpt_factura.pdf", :type => 'application/pdf', :disposition => 'inline')


          

      when "To Excel" then render xlsx: 'rpt_facturas_xls'
        
      else render action: "index"
    end





  end
# Export serviceorder to PDF
  def rpt_facturas_all2_pdf

    $lcFacturasall = '0'
    @company=Company.find(params[:company_id])          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
    @cliente = params[:customer_id]     

    @facturas_rpt = @company.get_facturas_day_cliente(@fecha1,@fecha2,@cliente)  


    Prawn::Document.generate("app/pdf_output/rpt_factura.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt(pdf)
        pdf = build_pdf_body_rpt(pdf)
        build_pdf_footer_rpt(pdf)
        $lcFileName =  "app/pdf_output/rpt_factura_all.pdf"              
    end     
    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_factura.pdf", :type => 'application/pdf', :disposition => 'inline')
  end

  ###pendientes de pago 




  def rpt_ccobrar2_pdf
  
    $lcxCliente ="1"
    @company=Company.find(1)      
    
    lcmonedadolares ="1"
    lcmonedasoles ="2"
    
    @fecha1 = params[:fecha1]  
    @fecha2 = params[:fecha2]

   @company.actualizar_fecha2
#   @company.actualizar_detraccion 


    @facturas_rpt = @company.get_pendientes_day(@fecha1,@fecha2)  

    case params[:print]


      when "To PDF" then 
            $lcxCliente ="0"
            @company=Company.find(1)      
            @fecha1 = params[:fecha1]    
            @fecha2 = params[:fecha2]

            lcmonedadolares ="1"
            lcmonedasoles ="2"
          
            @company.actualizar_fecha2
            @facturas_rpt = @company.get_pendientes_day_cliente1(@fecha1,@fecha2)  

              
            Prawn::Document.generate("app/pdf_output/rpt_pendientes.pdf")  do |pdf|
                pdf.font "Helvetica"
                pdf = build_pdf_header_rpt2(pdf)
                pdf = build_pdf_body_rpt2(pdf)
                build_pdf_footer_rpt2(pdf)

                $lcFileName =  "app/pdf_output/rpt_pendientes.pdf"     

                       
            end     

            $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName 

            send_file("app/pdf_output/rpt_pendientes.pdf", :type => 'application/pdf', :disposition => 'inline')
          

      when "To Excel" then render xlsx: 'rpt_ccobrar2_xls'
        
      else render action: "index"
    end
  end
  
 
  
  ###pendientes de pago 
  def rpt_ccobrar3_pdf

    $lcxCliente ="1"
    @company=Company.find(params[:company_id])      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]
    @cliente = params[:customer_id]      

    @facturas_rpt = @company.get_pendientes_day_cliente(@fecha1,@fecha2,@cliente)  


    if @facturas_rpt.size > 0 

    Prawn::Document.generate("app/pdf_output/rpt_pendientes.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt2(pdf)
        pdf = build_pdf_body_rpt2(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_pendientes.pdf"              
    end     


    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_pendientes.pdf", :type => 'application/pdf', :disposition => 'inline')

    end 

  end
  
  ###pendientes de pago detalle

  def rpt_ccobrar4_pdf
      $lcxCliente ="0"
      @company=Company.find(params[:company_id])          
      @fecha1 = params[:fecha1]  
      @fecha2 = params[:fecha2]  
      @facturas_rpt = @company.get_pendientes_day(@fecha1,@fecha2)  
      
      Prawn::Document.generate("app/pdf_output/rpt_pendientes4.pdf") do |pdf|
          pdf.font "Helvetica"
          pdf = build_pdf_header_rpt4(pdf)
          pdf = build_pdf_body_rpt4(pdf)
          build_pdf_footer_rpt4(pdf)
          $lcFileName =  "app/pdf_output/rpt_pendientes4.pdf"              
      end     
      $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
      send_file("app/pdf_output/rpt_pendientes4.pdf", :type => 'application/pdf', :disposition => 'inline')
  
  end
  

  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def invoice_headers_rpt            
      invoice_headers  = [["Fecha : ",$lcHora]]    
      invoice_headers
  end




 ## imprimir pdf facturas

    def print
        @invoice = Factura.find(params[:id])
        
        lib = File.expand_path('../../../lib', __FILE__)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


       
        require 'sunat'
        require './config/config'
        require './app/generators/invoice_generator'
        require './app/generators/credit_note_generator'
        require './app/generators/debit_note_generator'
        require './app/generators/receipt_generator'
        require './app/generators/daily_receipt_summary_generator'
        require './app/generators/voided_documents_generator'

        SUNAT.environment = :production 

        files_to_clean = Dir.glob("*.xml") + Dir.glob("./app/pdf_output/*.pdf") + Dir.glob("*.zip")
        files_to_clean.each do |file|
          File.delete(file)
        end         
       ################################### FF01-0

       $lcDocumentId = @invoice.document_id 

       if @invoice.document_id == 2 ||  @invoice.document_id == 9
        @serie_factura = @invoice.code[0..3].rjust(4,"0")
        puts "serie factura : "
        puts @serie_factura

        else 
           @serie_factura =  @invoice.code[0..3]
               puts "serie factura : "
             puts @serie_factura
      end 
      
       if @invoice.document_id == 5
           if @invoice.moneda_id == 1
                case_96 = ReceiptGenerator.new(12, 96, 1,@serie_factura,@invoice.id).with_different_currency2(true)
            else        
                case_52 = ReceiptGenerator.new(8, 52, 1,@serie_factura,@invoice.id).with_igv2(true)
            end 

       end     

        if @invoice.document_id == 2
           if @invoice.moneda_id == 1  
                $lcFileName=""
                 $lcMonedaValor ="USD"

                case_49 = InvoiceGenerator.new(1,3,1,@serie_factura,@invoice.id).with_different_currency2(true)
              #  puts $lcFileName 

           else
                   $lcMonedaValor ="PEN"
                case_3  = InvoiceGenerator.new(1,3,1,@serie_factura,@invoice.id).with_igv2(true)


           end        
        end 
        


   if @invoice.document_id == 9

      parts = @invoice.fecha.to_s.split("-")
          $aa = parts[0].to_i
          $mm = parts[1].to_i        
          $dd = parts[2].to_i      

          $lcVVenta1      =  @invoice.subtotal * 100 * -1      
          $lcVVenta       =  $lcVVenta1.round(0)

          $lcIgv1         =  @invoice.tax * 100 * -1
          $lcIgv          =  $lcIgv1.round(0)

          $lcTotal1       =  @invoice.total * 100 * -1
          $lcTotal        =  $lcTotal1.round(0)
     
          @invoice_detail = InvoiceService.where(factura_id: @invoice.id).first 


          $lcPrecioCigv1  =  @invoice_detail.price * 100
          $lcPrecioCigv2   = $lcPrecioCigv1.round(0).to_f
          $lcPrecioCigv   =  $lcPrecioCigv2.to_i 

          $lcPrecioSigv1  =  (@invoice_detail.price / 1.18) * 100
          $lcPrecioSigv2   = $lcPrecioSigv1.round(0).to_f
          $lcPrecioSIgv   =  $lcPrecioSigv2.to_i 

           $lcDescrip = "ANULACION DE FACTURA"   
        
          if @invoice.moneda_id == 1
                  $lcMonedaValor ="USD"
          else
                  $lcMonedaValor ="PEN"
          end

    
        
        credit_note_data = { issue_date: Date.new($aa,$mm,$dd), id: @invoice.code , customer: {legal_name:@invoice.customer.name , ruc:@invoice.customer.ruc  },
                             billing_reference: {id: @invoice.documento2, document_type_code: "01"},
                             discrepancy_response: {reference_id:@invoice.documento2, response_code: "09", description: $lcDescrip},
                            
                            lines: [{id: "1", item: {id: "05", description: @invoice_detail.service.name }, quantity: @invoice_detail.quantity, unit: 'ZZ', 
                                  price: {value: @lcPrecioSIgv },
                                   pricing_reference: $lcPrecioCigv, tax_totals: [{amount: $lcIgv, type: :igv, code: "10"}], 
                                   line_extension_amount:$lcVVenta }],
                             additional_monetary_totals: [{id: "1001", payable_amount: $lcVVenta}], tax_totals: [{amount: $lcIgv, type: :igv}], legal_monetary_total: {value: $lcTotal, currency: $lcMonedaValor }}
         

     
        if @invoice.moneda_id == 2
              puts "dolares "
          
             credit_note = SUNAT::CreditNote.new(credit_note_data)
  
            $aviso = 'Nota enviada con exito...$$'
        else            
       
             credit_note = SUNAT::CreditNote.new(credit_note_data)
            $aviso = 'Nota enviada con exito...'
        end 

        if credit_note.valid?                       
           credit_note.to_pdf    
           document_type_code = "07"
           file_name =   "20424092941-#{document_type_code}-#{@invoice.code}"+".pdf"
            $lcFileName1=File.expand_path('../../../', __FILE__)+ "/app/pdf_output/"+file_name  

            send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')      
          

        else
          
          $aviso = "Invalid document, ignoring output: #{credit_note.errors.messages}"

        end

      end 

      if @invoice.document_id == 10


        parts = @invoice.fecha.to_s.split("-")
          $aa = parts[0].to_i
          $mm = parts[1].to_i        
          $dd = parts[2].to_i      

          $lcVVenta1      =  @invoice.subtotal * 100        
          $lcVVenta       =  $lcVVenta1.round(0)

          $lcIgv1         =  @invoice.tax * 100
          $lcIgv          =  $lcIgv1.round(0)

          $lcTotal1       =  @invoice.total * 100
          $lcTotal        =  $lcTotal1.round(0)
     
          @invoice_detail = InvoiceService.where(factura_id: @invoice.id).first 


          $lcPrecioCigv1  =  @invoice_detail.price * 100
          $lcPrecioCigv2   = $lcPrecioCigv1.round(0).to_f
          $lcPrecioCigv   =  $lcPrecioCigv2.to_i 

          $lcPrecioSigv1  =  (@invoice_detail.price / 1.18) * 100
          $lcPrecioSigv2   = $lcPrecioSigv1.round(0).to_f
          $lcPrecioSIgv   =  $lcPrecioSigv2.to_i 

           $lcDescrip = "AUMENTO EN EL VALOR "  

           if @invoice.moneda_id == 1
                  $lcMonedaValor ="USD"
          else
                  $lcMonedaValor ="PEN"
          end 

          debit_note_data = { issue_date: Date.new($aa,$mm,$dd), id: @invoice.code, customer: {legal_name: @invoice.customer.name , ruc: @invoice.customer.ruc },
                     billing_reference: {id: @invoice.documento2, document_type_code: "01"},
                     discrepancy_response: {reference_id: @invoice.documento2, response_code: "02", description: $lcDescrip},
                     lines: [{id: "1", item: {id: "05", description: @invoice_detail.service.name }, quantity: @invoice_detail.quantity, unit: 'ZZ', 
                          price: {value: $lcPrecioCigv}, pricing_reference: $lcPrecioCigv, tax_totals: [{amount: $lcIgv, type: :igv, code: "10"}], line_extension_amount:$lcVVenta }],
                     additional_monetary_totals: [{id: "1001", payable_amount: $lcVVenta}], tax_totals: [{amount: $lcIgv, type: :igv}], legal_monetary_total: $lcTotal}

          debit_note = SUNAT::DebitNote.new(debit_note_data)
          

        if debit_note.valid?
            debit_note.to_pdf
           document_type_code = "08"
           file_name =   "20424092941-#{document_type_code}-#{@invoice.code}"+".pdf"
            $lcFileName1=File.expand_path('../../../', __FILE__)+ "/app/pdf_output/"+file_name  

            send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
        else          
          $aviso = "Invalid document, ignoring output: #{debit_note.errors.messages}"  
          puts $aviso         
        end


      end 
        
    

        $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
        send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
        @@document_serial_id =""
        $aviso=""
  
    
  
    end 


   

  private
  def factura_params
    params.require(:factura).permit(:company_id,:location_id, :division_id, :customer_id, :description , :comments , :code , 
      :subtotal, :tax , :total , :processed, :return , :date_processed, :user_id ,:fecha, :serie , :numero , :payment_id , :tipo,
       :pago, :charge, :balance, :moneda_id, :observ, :fecha2, :year_mounth , :contrato_id, :anio ,:medio_id, :document_id ,
        :tc, :nacional , :orden_id , :msgerror, :cuota1, :fecha_cuota1, :importe_cuota1 , :cuota2 ,:fecha_cuota2, :importe_cuota2,
         :cuota3 , :fecha_cuota3 , :importe_cuota3 , :cuota4, :fecha_cuota4, :importe_cuota4 , :cuota5 ,:fecha_cuota5 ,
        :importe_cuota5 , :detraccion_percent ,:detraccion_importe , :detraccion_cuenta, :retencion_importe,:tipo_factura,
        :orden_comision )
  end

end


