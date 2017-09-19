include UsersHelper
include CustomersHelper
include AvisodetailsHelper

class OrdensController < ApplicationController
  before_filter :authenticate_user!,:checkProducts
  
  
##-------------------------------------------------------------------------------------
## REPORTE DE ESTADISTICA DE VENTAS
##-------------------------------------------------------------------------------------
  
  def build_pdf_header_rpt2(pdf)
     pdf.font "Helvetica" , :size => 6
      
     $lcCli  =  @orden.customer.name 
     $lcRucCli =  @orden.customer.ruc
     $lcDirCli = ""  
     
       $lcMoneda ="NUEVOS SOLES "
     
     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s    
        
      pdf.image "#{Dir.pwd}/public/images/logo2.png", :width => 120
        
      pdf.move_down 25
        
      #pdf.text supplier.street, :size => 10
      #pdf.text supplier.district, :size => 10
      #pdf.text supplier.city, :size => 1
    
       
       pdf.bounding_box([555, 525], :width => 200, :height => 80) do
        pdf.stroke_bounds
        pdf.move_down 15
        pdf.font "Helvetica", :style => :bold do
          pdf.text "R.U.C: 20100040009008", :align => :center,:size => 10
          pdf.text "ORDEN DE TRANSMISION", :align => :center,:size  =>10
          pdf.text "#{@orden.code}", :align => :center,:size  =>10,
                                 :style => :bold
          
        end
      end
   
    pdf.text "Lima, " << @orden.fecha.strftime("%d/%m/%Y") ,:size =>10 ,:style=> :bold 
    #pdf.text "Marca: " << $lcMarca ,:size =>10 ,:style=> :bold 
    pdf 


  end   

  def build_pdf_body_rpt2(pdf)
    
    
   pdf.move_down 2
    pdf.font "Helvetica" , :size => 6
    pdf.text "________________________________________________________________________________________________________", :size => 13, :spacing => 4
    pdf.text " ", :size => 13
    pdf.font "Helvetica" , :size => 8
   pdf.move_down 5
    max_rows = [invoice_headers.length,client_data_headers.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (invoice_headers.length >= row ? invoice_headers[rows_index] : ['',''])
        rows[rows_index] += (client_data_headers.length >= row ? client_data_headers[rows_index] : ['',''])
        
      end

      if rows.present?

        pdf.table(rows, {
          :position => :center,
          :cell_style => {:border_width => 0},
          :width => pdf.bounds.width
        }) do
          columns([0, 2]).font_style = :bold

        end

        pdf.move_down 5

      end
        
         pdf.font "Helvetica" , :size => 6
      pdf.move_down 10
      headers = []
      table_content = []
      total_general = 0
      total_factory = 0

      Orden::TABLE_HEADERS2.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end
      table_content << headers

      nroitem = 1

      # tabla pivoteadas
      # hash of hashes
        # pad columns with spaces and bars from max_lengths

      @total_general = 0
      @total_anterior = 0
      @total_cliente = 0 

      @total_dia01 = 0
      @total_dia02 = 0
      @total_dia03 = 0
      @total_dia04 = 0
      @total_dia05 = 0
      @total_dia06 = 0
      @total_dia07 = 0
      @total_dia08 = 0
      @total_dia09 = 0
      @total_dia10 = 0
      @total_dia11 = 0
      @total_dia12 = 0
      @total_dia13 = 0
      @total_dia14 = 0
      @total_dia15 = 0
      @total_dia16 = 0
      @total_dia17 = 0
      @total_dia18 = 0
      @total_dia19 = 0
      @total_dia20 = 0
      @total_dia21 = 0
      @total_dia22 = 0
      @total_dia23 = 0
      @total_dia24 = 0
      @total_dia25 = 0
      @total_dia26 = 0
      @total_dia27 = 0
      @total_dia28 = 0
      @total_dia29 = 0
      @total_dia30 = 0
      @total_dia31 = 0


      @total_anterior_column = 0
      @total_linea_general = 0

      @total_dia01_column = 0
      @total_dia02_column = 0
      @total_dia03_column = 0
      @total_dia04_column = 0
      @total_dia05_column = 0
      @total_dia06_column = 0
      @total_dia07_column = 0
      @total_dia08_column = 0
      @total_dia09_column = 0
      @total_dia10_column = 0
      @total_dia11_column = 0
      @total_dia12_column = 0
      @total_dia13_column = 0
      @total_dia14_column = 0
      @total_dia15_column = 0
      @total_dia16_column = 0
      @total_dia17_column = 0
      @total_dia18_column = 0
      @total_dia19_column = 0
      @total_dia20_column = 0
      @total_dia21_column = 0
      @total_dia22_column = 0
      @total_dia23_column = 0
      @total_dia24_column = 0
      @total_dia25_column = 0
      @total_dia26_column = 0
      @total_dia27_column = 0
      @total_dia28_column = 0
      @total_dia29_column = 0
      @total_dia30_column = 0
      @total_dia31_column = 0                      

      @orden_detalle =  @orden.get_orden_products()

      lcCli = @orden_detalle.first.avisodetail_id
      $lcCliName = ""
    

     for  order in @orden_detalle 

        
            
            row = []
            row << nroitem.to_s        
            row << order.avisodetail.descrip 
            
            row << sprintf("%.0f",order.d01.to_s)
            row << sprintf("%.0f",order.d02.to_s)
            row << sprintf("%.0f",order.d03.to_s)
            row << sprintf("%.0f",order.d04.to_s)
            row << sprintf("%.0f",order.d05.to_s)
            row << sprintf("%.0f",order.d06.to_s)
            row << sprintf("%.0f",order.d07.to_s)
            row << sprintf("%.0f",order.d08.to_s)
            row << sprintf("%.0f",order.d09.to_s)
            row << sprintf("%.0f",order.d10.to_s)
            row << sprintf("%.0f",order.d11.to_s)
            row << sprintf("%.0f",order.d12.to_s)
            row << sprintf("%.0f",order.d13.to_s)
            row << sprintf("%.0f",order.d14.to_s)
            row << sprintf("%.0f",order.d15.to_s)
            row << sprintf("%.0f",order.d16.to_s)
            row << sprintf("%.0f",order.d17.to_s)
            row << sprintf("%.0f",order.d18.to_s)
            row << sprintf("%.0f",order.d19.to_s)
            row << sprintf("%.0f",order.d20.to_s)
            row << sprintf("%.0f",order.d21.to_s)
            row << sprintf("%.0f",order.d22.to_s)
            row << sprintf("%.0f",order.d23.to_s)
            row << sprintf("%.0f",order.d24.to_s)
            row << sprintf("%.0f",order.d25.to_s)
            row << sprintf("%.0f",order.d26.to_s)
            row << sprintf("%.0f",order.d27.to_s)
            row << sprintf("%.0f",order.d28.to_s)
            row << sprintf("%.0f",order.d29.to_s)
            row << sprintf("%.0f",order.d30.to_s)
            row << sprintf("%.0f",order.d31.to_s)
            
            
            @total_dia01_column += order.d01
            @total_dia02_column += order.d02
            @total_dia03_column += order.d03
            @total_dia04_column += order.d04
            @total_dia05_column += order.d05
            @total_dia06_column += order.d06
            @total_dia07_column += order.d07
            @total_dia08_column += order.d08
            @total_dia09_column += order.d09
            @total_dia10_column += order.d10
            @total_dia11_column += order.d11
            @total_dia12_column += order.d12
            @total_dia13_column += order.d13
            @total_dia14_column += order.d14
            @total_dia15_column += order.d15
            @total_dia16_column += order.d16
            @total_dia17_column += order.d17
            @total_dia18_column += order.d18
            @total_dia19_column += order.d19
            @total_dia20_column += order.d20
            @total_dia21_column += order.d21
            @total_dia22_column += order.d22
            @total_dia23_column += order.d23
            @total_dia24_column += order.d24
            @total_dia25_column += order.d25
            @total_dia26_column += order.d26
            @total_dia27_column += order.d27
            @total_dia28_column += order.d28
            @total_dia29_column += order.d29
            @total_dia30_column += order.d30
            @total_dia31_column += order.d31

            @total_linea = order.d01+order.d02+order.d03+order.d04+order.d05+order.d06+order.d07+order.d08+order.d09+order.d10+
                           order.d11+order.d12+order.d13+order.d14+order.d15+order.d16+order.d17+order.d18+order.d19+order.d20+
                           order.d21+order.d22+order.d23+order.d24+order.d25+order.d26+order.d27+order.d28+order.d29+order.d30+order.d31
            row << sprintf("%.2f",@total_linea.to_s)
            row << sprintf("%.2f",order.price.to_s)
            row << sprintf("%.2f",order.tarifa.to_s)
            row << sprintf("%.2f",order.total.to_s)
            
            table_content << row            
             @total_linea_general += @total_linea

              @total_linea = 0 

          nroitem = nroitem + 1 

         
       end   

      #fin for
          #ultimo cliente 

          
     

           
            
        
        row = []
         row << ""       
         row << " TOTAL GENERAL => "         
         row << sprintf("%.0f",@total_dia01_column.to_s)
         row << sprintf("%.0f",@total_dia02_column.to_s)
         row << sprintf("%.0f",@total_dia03_column.to_s)
         row << sprintf("%.0f",@total_dia04_column.to_s)
         row << sprintf("%.0f",@total_dia05_column.to_s)
         row << sprintf("%.0f",@total_dia06_column.to_s)
         row << sprintf("%.0f",@total_dia07_column.to_s)
         row << sprintf("%.0f",@total_dia08_column.to_s)
         row << sprintf("%.0f",@total_dia09_column.to_s)
         row << sprintf("%.0f",@total_dia10_column.to_s)
         row << sprintf("%.0f",@total_dia11_column.to_s)
         row << sprintf("%.0f",@total_dia12_column.to_s)
         row << sprintf("%.0f",@total_dia13_column.to_s)
         row << sprintf("%.0f",@total_dia14_column.to_s)
         row << sprintf("%.0f",@total_dia15_column.to_s)
         row << sprintf("%.0f",@total_dia16_column.to_s)
         row << sprintf("%.0f",@total_dia17_column.to_s)
         row << sprintf("%.0f",@total_dia18_column.to_s)
         row << sprintf("%.0f",@total_dia19_column.to_s)
         row << sprintf("%.0f",@total_dia20_column.to_s)
         row << sprintf("%.0f",@total_dia21_column.to_s)
         row << sprintf("%.0f",@total_dia22_column.to_s)
         row << sprintf("%.0f",@total_dia23_column.to_s)
         row << sprintf("%.0f",@total_dia24_column.to_s)
         row << sprintf("%.0f",@total_dia25_column.to_s)
         row << sprintf("%.0f",@total_dia26_column.to_s)
         row << sprintf("%.0f",@total_dia27_column.to_s)
         row << sprintf("%.0f",@total_dia28_column.to_s)
         row << sprintf("%.0f",@total_dia29_column.to_s)
         row << sprintf("%.0f",@total_dia30_column.to_s)
         row << sprintf("%.0f",@total_dia31_column.to_s)
         row << sprintf("%.2f",@total_linea_general.to_s)
         row << " "
         row << " "
         row << " "
    table_content << row            

      
         


      result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width
                                        } do 
                                          columns([0]).align=:center
                                          columns([1]).align=:left
                                          columns([2]).align=:right
                                          columns([3]).align=:right 
                                          columns([4]).align=:right
                                          columns([5]).align=:right 
                                          columns([6]).align=:right
                                          columns([7]).align=:right 
                                          columns([8]).align=:right
                                          columns([9]).align=:right 
                                          columns([10]).align=:right
                                          columns([11]).align=:right 
                                          columns([12]).align=:right
                                          columns([13]).align=:right 
                                          columns([14]).align=:right 
                                          columns([15]).align=:right
                                          columns([16]).align=:left
                                          columns([17]).align=:right
                                          columns([18]).align=:right 
                                          columns([19]).align=:right
                                          columns([20]).align=:right 
                                          columns([21]).align=:right
                                          columns([22]).align=:right 
                                          columns([23]).align=:right
                                          columns([24]).align=:right 
                                          columns([25]).align=:right
                                          columns([26]).align=:right 
                                          columns([27]).align=:right
                                          columns([28]).align=:right 
                                          columns([29]).align=:right 
                                          columns([30]).align=:right
                                          columns([31]).align=:right
                                          columns([32]).align=:right
                                          columns([33]).align=:right
                                          columns([34]).align=:right
                                        end                                          
      pdf.move_down 10    
      pdf.text  "Observaciones : " + @orden.description


      pdf

    end


    def build_pdf_footer_rpt2(pdf)

        subtotals = []
        taxes = []
        totals = []
        services_subtotal = 0
        services_tax = 0
        services_total = 0    
        
        pdf.move_down 10      
 lcTexto=     "Los espacios,fechas y ubicaciones no seran modificados sin permiso de la agencia.No se ubicarán en la misma tanda/página, al lado, al frente o a continuación de otra publicación de similares"
 
data =[ [lcTexto,"Dpto.Medios","Recibido por el medios."],
               
               ["","Firma."," "]          ]

           
            pdf.text " "
            pdf.table invoice_summary, {
        :position => :right,
        :cell_style => {:border_width => 1},
        :width => pdf.bounds.width/4
      } do
        columns([0]).font_style = :bold
        columns([1]).align = :right
        
      end
      
      pdf.table(data,:cell_style=> {:border_width=>1} , :width => pdf.bounds.width/3,:position => :center)
            
        
        
      
        pdf.text "" 

        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end




  # Reporte de orden 
  def pdf
    @orden = Orden.find(params[:id])
    @company = Company.find(1)        
    Prawn::Document.generate("app/pdf_output/rpt_orden2.pdf") do |pdf|        

        pdf.start_new_page(:size => "A4", :layout => :landscape)

        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt2(pdf)
        pdf = build_pdf_body_rpt2(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')


  end
  
  # Process an orden
  def do_process
    @orden = Orden.find(params[:id])
    @orden[:processed] = "1"
    
    @orden.process
    
    flash[:notice] = "The orden order has been processed."
    redirect_to @orden
  end
  
  # Do send orden via email
  def do_email
    @orden = Orden.find(params[:id])
    @email = params[:email]
    
    Notifier.orden(@email, @orden).deliver
    
    flash[:notice] = "The orden has been sent successfully."
    redirect_to "/ordens/#{@orden.id}"
  end

  
  # Send orden via email
  def email
    @orden = Orden.find(params[:id])
    @company = @orden.company
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
             
#item_id + "|BRK|"+fecha_dd + "|BRK|" + fecha_mm + "|BRK|" +fecha_yy + "|BRK|" + quantity + "|BRK|" + tarifa ;
       # fecha_dd   = parts[1]        
       # fecha_mm   = parts[2]        
       # fecha_aa   = parts[3]        
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
        
        
        price      = parts[32]        
        tarifa     = parts[33]
        total      = parts[34]  
        
        product = Avisodetail.find(id.to_i)

        product[:i] = i
        product[:tarifa] = tarifa.to_f
        product[:price]  = price.to_f
        product[:total]  = total.to_f
        
        product[:d01] = dia_01.to_f
        product[:d02] = dia_02.to_f
        product[:d03] = dia_03.to_f
        product[:d04] = dia_04.to_f
        product[:d05] = dia_05.to_f
        product[:d06] = dia_06.to_f
        product[:d07] = dia_07.to_f
        product[:d08] = dia_08.to_f
        product[:d09] = dia_09.to_f
        product[:d10] = dia_10.to_f
        product[:d11] = dia_11.to_f
        product[:d12] = dia_12.to_f
        product[:d13] = dia_13.to_f
        product[:d14] = dia_14.to_f
        product[:d15] = dia_15.to_f
        product[:d16] = dia_16.to_f
        product[:d17] = dia_17.to_f
        product[:d18] = dia_18.to_f
        product[:d19] = dia_19.to_f
        product[:d20] = dia_20.to_f
        product[:d21] = dia_21.to_f
        product[:d22] = dia_22.to_f
        product[:d23] = dia_23.to_f
        product[:d24] = dia_24.to_f
        product[:d25] = dia_25.to_f
        product[:d26] = dia_26.to_f
        product[:d27] = dia_27.to_f
        product[:d28] = dia_28.to_f
        product[:d29] = dia_29.to_f
        product[:d30] = dia_30.to_f
        product[:d31] = dia_31.to_f
        
  
        @products.push(product)
      end
      
      i += 1
   end
    
    render :layout => false
  end
  
  
  # Autocomplete for products
  def ac_programs
    @products = Avisodetail.where(["(descrip iLIKE ?)", "%" +params[:q] + "%"])
   
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
    @customers = Customer.where(["company_id = ? AND (ruc  iLIKE ? OR name iLIKE ?)", params[:company_id], "%" + params[:q] + "%", "%" + params[:q] + "%"])
   
    render :layout => false
  end
  
  # Show ordens for a company
  def list_ordens
    @company = Company.find(params[:company_id])
    @pagetitle = "#{@company.name} - ordens"
    @filters_display = "block"
    
    if(@company.can_view(current_user))
      if(params[:ac_customer] and params[:ac_customer] != "")
        @customer = Customer.find(:first, :conditions => {:company_id => @company.id, :name => params[:ac_customer].strip})
        
        if @customer
          @ordens = Orden.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :customer_id => @customer.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any ordens for that customer."
          redirect_to "/companies/ordens/#{@company.id}"
        end
      elsif(params[:customer] and params[:customer] != "")
        @customer = Customer.find(params[:customer])
        
        if @customer
          @ordens = Orden.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :customer_id => @customer.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any ordens for that customer."
          redirect_to "/companies/ordens/#{@company.id}"
        end
      elsif(params[:location] and params[:location] != "" and params[:division] and params[:division] != "")
        @ordens = Orden.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location], :division_id => params[:division]}, :order => "id DESC")
      elsif(params[:location] and params[:location] != "")
        @ordens = Orden.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location]}, :order => "id DESC")
      elsif(params[:division] and params[:division] != "")
        @ordens = Orden.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :division_id => params[:division]}, :order => "id DESC")
      else
        if(params[:q] and params[:q] != "")
          fields = ["description", "comments", "code"]

          q = params[:q].strip
          @q_org = q

          query = str_sql_search(q, fields)

          @ordens = Orden.paginate(:page => params[:page], :order => 'id DESC', :conditions => ["company_id = ? AND (#{query})", @company.id])
        else
          @ordens = Orden.where(company_id:  @company.id).order("id DESC").paginate(:page => params[:page])
          @filters_display = "none"
        end
      end
    else
      errPerms()
    end
  end
  
  # GET /ordens
  # GET /ordens.xml
  def index
    @companies = Company.where(user_id: current_user.id).order("name")
    @path = 'ordens'
    @pagetitle = "ordens"

  end

  # GET /ordens/1
  # GET /ordens/1.xml
  def show
    @orden = Orden.find(params[:id])
    @customer = @orden.customer
    @motivos =Motivo.all
    @medios = Medio.all
    @marcas= Marca.all 
    @versions = Version.all 
    
    @ordens_products = @orden.orden_products
  end

  # GET /ordens/new
  # GET /ordens/new.xml

  
  
  def new
    @pagetitle = "New orden"
    @action_txt = "Create"

    if(params[:year] and params[:year].numeric?)
      @year = params[:year].to_i
    else
      @year = Time.now.year
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
    
    curr_year = Time.now.year
    c_year = curr_year
    c_month = 1
    
    @years = []
    @months = monthsArr
    @month_name = @months[@month - 1][0]
    
    
    
    while(c_year > Time.now.year - 5)
      @years.push(c_year)
      c_year -= 1
    end
    
    @dates = []
    
    last_day_of_month = last_day_of_month(@year, @month)
    @date_cats = []
    
    i = 1
    
    while(i <= last_day_of_month)
      if(i < 10)
        i_s = "0#{i}"
      else
        i_s = i.to_s
      end
      
      @dates.push("#{@year}-#{month_s}-#{i_s}")
      @date_cats.push("'" + doDate(Time.parse("#{@year}-#{@month}-#{i_s}"), 5) + "'")
      
      i += 1
    end
    

    @customers = Customer.all
    @motivos =Motivo.all
    @medios = Medio.all    
    @marcas= Marca.all 
    @versions = Version.all 
    @contratos = Contrato.all 

    @orden = Orden.new
    @orden[:code] = "#{generate_guid12()}"
    
    @orden[:processed] = false
    @orden[:tiempo] = 30
    
    @company = Company.find(params[:company_id])
    @orden.company_id = @company.id
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    
    
    @ac_user = getUsername()
    @orden[:user_id] = getUserId()
  end


  # GET /ordens/1/edit
  def edit
    @pagetitle = "Edit orden"
    @action_txt = "Update"
    
    
    @orden = Orden.find(params[:id])
    @company = @orden.company
    @ac_customer = @orden.customer.name
    @ac_user = @orden.user.username


#-------
      if(params[:year] and params[:year].numeric?)
      @year = params[:year].to_i
    else
      @year = Time.now.year
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
    
    curr_year = Time.now.year
    c_year = curr_year
    c_month = 1
    
    @years = []
    @months = monthsArr
    @month_name = @months[@month - 1][0]
    
    
    
    while(c_year > Time.now.year - 5)
      @years.push(c_year)
      c_year -= 1
    end
    
    @dates = []
    
    last_day_of_month = last_day_of_month(@year, @month)
    @date_cats = []
    
    i = 1
    
    while(i <= last_day_of_month)
      if(i < 10)
        i_s = "0#{i}"
      else
        i_s = i.to_s
      end
      
      @dates.push("#{@year}-#{month_s}-#{i_s}")
      @date_cats.push("'" + doDate(Time.parse("#{@year}-#{@month}-#{i_s}"), 5) + "'")
      
      i += 1
    end
    
    #-------
    
    
    @customers = Customer.all
    @motivos =Motivo.all
    @medios = Medio.all
    @marcas= Marca.all 
    @versions = Version.all 
    @contratos = Contrato.all 

    @products_lines = @orden.products_lines
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
  end

  # POST /ordens
  # POST /ordens.xml
  def create
    @pagetitle = "New orden"
    @action_txt = "Create"
    
    #-------
      if(params[:year] and params[:year].numeric?)
      @year = params[:year].to_i
    else
      @year = Time.now.year
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
    
    curr_year = Time.now.year
    c_year = curr_year
    c_month = 1
    
    @years = []
    @months = monthsArr
    @month_name = @months[@month - 1][0]
    
    
    
    while(c_year > Time.now.year - 5)
      @years.push(c_year)
      c_year -= 1
    end
    
    @dates = []
    
    last_day_of_month = last_day_of_month(@year, @month)
    @date_cats = []
    
    i = 1
    
    while(i <= last_day_of_month)
      if(i < 10)
        i_s = "0#{i}"
      else
        i_s = i.to_s
      end
      
      @dates.push("#{@year}-#{month_s}-#{i_s}")
      @date_cats.push("'" + doDate(Time.parse("#{@year}-#{@month}-#{i_s}"), 5) + "'")
      
      i += 1
    end
    
    #-------
    
    
      
    items = params[:items].split(",")
    
    @orden = Orden.new(orden_params)
    
    @company = Company.find(params[:orden][:company_id])
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    
    @customers = Customer.all
    @motivos =Motivo.all
    @medios = Medio.all
    @marcas= Marca.all 
    @versions = Version.all 
    @contratos = Contrato.all 
    @orden[:month]= @month 
    @orden[:year]= @year
    
    @orden[:subtotal] = @orden.get_subtotal(items)
    
    begin
      @orden[:tax] = @orden.get_tax(items, @orden[:customer_id])
    rescue
      @orden[:tax] = 0
    end
    
    @orden[:total] = @orden[:subtotal] + @orden[:tax]
    
    if(params[:orden][:user_id] and params[:orden][:user_id] != "")
      curr_seller = User.find(params[:orden][:user_id])
      @ac_user = curr_seller.username
    end

    respond_to do |format|
      if @orden.save
        # Create products for kit
        @orden.add_products(items)
        
        # Check if we gotta process the orden
        @orden.process()
        @orden.correlativo()
        
        format.html { redirect_to(@orden, :notice => 'orden was successfully created.') }
        format.xml  { render :xml => @orden, :status => :created, :location => @orden }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @orden.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /ordens/1
  # PUT /ordens/1.xml
  def update
    @pagetitle = "Edit orden"
    @action_txt = "Update"

    @customers = Customer.all
    @motivos =Motivo.all
    @medios = Medio.all
    @marcas= Marca.all 
    @versions = Version.all 
    @contratos = Contrato.all 

    items = params[:items].split(",")
    
    @orden =Orden.find(params[:id])
    @company = Company.find(1)
    
    if(params[:ac_customer] and params[:ac_customer] != "")
      @ac_customer = params[:ac_customer]
    else
      @ac_customer = @orden.customer.name
    end
    
    @products_lines = @orden.products_lines
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    
    @orden[:subtotal] = @orden.get_subtotal(items)
    @orden[:tax] = @orden.get_tax(items, @orden[:customer_id])
    @orden[:total] = @orden[:subtotal] + @orden[:tax]

    respond_to do |format|
      if @orden.update_attributes(orden_params)
        # Create products for kit
        @orden.delete_products()
        @orden.add_products(items)
        
        # Check if we gotta process the orden
        @orden.process()
        
        format.html { redirect_to(@orden, :notice => 'orden was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orden.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ordens/1
  # DELETE /ordens/1.xml
  def destroy
    @orden = Orden.find(params[:id])
    company_id = @orden[:company_id]
    @orden.destroy

    respond_to do |format|
      format.html { redirect_to("/companies/ordens/" + company_id.to_s) }
    end
  end



  # reporte completo
  def build_pdf_header_rpt5(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers_rpt.length, orden_headers_rpt.length, 0].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers_rpt.length >= row ? client_data_headers_rpt[rows_index] : ['',''])
        rows[rows_index] += (orden_headers_rpt.length >= row ? orden_headers_rpt[rows_index] : ['',''])
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

  def build_pdf_body_rpt5(pdf)
    
    pdf.text "Listado de Ordenes desde "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 
  
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Orden::TABLE_HEADERS.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

      @totales = 0
      @cantidad = 0
      nroitem = 1


       for  product in @ordenes_rpt
 
            row = []         
            row << nroitem.to_s
            row << product.contrato.code
            row << product.fecha.strftime("%d/%m/%Y")
            row << ""
            row << product.medio.descrip
            row << product.marca.descrip            
            row << product.version.descrip
            row << product.tiempo 
            row << product.fecha1.strftime("%d/%m/%Y")
            row << product.fecha2.strftime("%d/%m/%Y")
            
            table_content << row

            @totales += 0
            

            nroitem=nroitem + 1
       
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
                                          columns([5]).align=:center  
                                          columns([6]).align=:right
                                          columns([7]).align=:right
                                          columns([8]).align=:right
                                          columns([9]).align=:right
                                          columns([10]).align=:right
                                        end                                          
      pdf.move_down 10      
      #totales 
      pdf 

    end

    def build_pdf_footer_rpt5(pdf)            
                        
      pdf.text "" 
      pdf.bounding_box([0, 30], :width => 535, :height => 40) do
      pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end

  def rpt_ordenes1
  
    @company=Company.find(params[:company_id])          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
    
    @ordenes_rpt = @company.get_ordenes_day(@fecha1,@fecha2)

    Prawn::Document.generate("app/pdf_output/rpt_ordenes1.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt5(pdf)
        pdf = build_pdf_body_rpt5(pdf)
        build_pdf_footer_rpt5(pdf)
        $lcFileName =  "app/pdf_output/rpt_ordenes1.pdf"              
    end     
    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_ordenes1.pdf", :type => 'application/pdf', :disposition => 'inline')

  end


#fin reporte de ingresos x producto 


 def client_data_headers

    #{@purchaseorder.description}
      $lcContrato =  @orden.contrato.code
     $lcMedio  = @orden.medio.descrip
     $lcMarca  = @orden.marca.descrip
     $lcVersion = @orden.version.descrip
     $lcFechaMes = @orden.month.to_i  
     @months = monthsArr
     @month_name = @months[$lcFechaMes - 1][0] <<" - " <<@orden.year.to_s
    
     
     
     $lcMoneda ="NUEVOS SOLES "
     
      client_headers  = [["Marca: ", $lcMarca]] 
      client_headers << ["Version  : ",$lcVersion]
      client_headers << ["Emision campaña : ",@month_name ]     
      client_headers
  end

  def invoice_headers            
      invoice_headers  = [["Cliente : ", $lcCli]]
      invoice_headers <<  ["RUC : ", $lcRucCli]
      invoice_headers <<  ["Direccion : ", $lcDircli]
      invoice_headers <<  ["Contrato : ", $lcContrato]
      invoice_headers
  end



  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def orden_headers_rpt            
      orden_headers  = [["Fecha : ",$lcHora]]    
      orden_headers
  end

  def invoice_summary
      invoice_summary = []
      invoice_summary << ["SubTotal",  ActiveSupport::NumberHelper::number_to_delimited(@orden.subtotal,delimiter:",",separator:".").to_s]
      invoice_summary << ["IGV",ActiveSupport::NumberHelper::number_to_delimited(@orden.tax,delimiter:",",separator:".").to_s]
      invoice_summary << ["Total", ActiveSupport::NumberHelper::number_to_delimited(@orden.total ,delimiter:",",separator:".").to_s]
      
      invoice_summary
    end
  def invoice_summary2
      invoice_summary2 = []
      invoice_summary2 << ["SubTotal",  ActiveSupport::NumberHelper::number_to_delimited(@orden.subtotal,delimiter:",",separator:".").to_s]
      invoice_summary2 << ["IGV",ActiveSupport::NumberHelper::number_to_delimited(@orden.tax,delimiter:",",separator:".").to_s]
      invoice_summary2 << ["Total", ActiveSupport::NumberHelper::number_to_delimited(@orden.total ,delimiter:",",separator:".").to_s]
      
      invoice_summary2
    end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden
      @orden = Orden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_params

    params.require(:orden).permit(:contrato_id,:fecha,:medio_id,:marca_id,:version_id,:fecha1,:fecha2,:tiempo,  
    :code,:company_id,:subtotal,:tax,:total,:user_id,:processed,:customer_id,:description,:d01,:d02,:d03,:d04,:d05,:d06,:d07,:d08,:d09,:d10,:d11,:d12,:d13,:d14,:d15,:d16,:d17,:d18,:d19,:d20,:d21,:d22,:d23,:d24,:d25,:d26,:d27,:d28,:d29,:d30,:d31,:revision )
  
    end

  

end
