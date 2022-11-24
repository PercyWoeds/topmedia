include UsersHelper
include SuppliersHelper
include ServicebuysHelper

class SupplierPaymentsController < ApplicationController

  before_filter :authenticate_user!, :checkServices

##-------------------------------------------------------------------------------------
## REPORTE DE ESTADISTICA DE VENTAS
##-------------------------------------------------------------------------------------
  
  def build_pdf_header_rpt2(pdf)
     pdf.font "Helvetica" , :size => 6
      
     $lcCli  = @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers.length, invoice_headers.length, 0].max
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

  def build_pdf_body_rpt2(pdf)
    
    if @tipomoneda == 1
       @tipomoneda_name ="DOLARES"  
    else
       @tipomoneda_name ="SOLES "  
    end 
    pdf.text "Resumen Proveedores Moneda : "+@tipomoneda_name  + " Fecha "+@fecha1.to_s+ " Mes : "+@fecha2.to_s , :size => 11 
    pdf.text ""
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []
      total_general = 0
      total_factory = 0

      CustomerPayment::TABLE_HEADERS6.each do |header|
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
      @total_mes01 = 0
      @total_mes02 = 0
      @total_mes03 = 0
      @total_mes04 = 0
      @total_mes05 = 0
      @total_mes06 = 0
      @total_mes07 = 0
      @total_mes08 = 0
      @total_mes09 = 0
      @total_mes10 = 0
      @total_mes11 = 0
      @total_mes12 = 0
      @total_anterior_column = 0
      @total_mes01_column = 0
      @total_mes02_column = 0
      @total_mes03_column = 0
      @total_mes04_column = 0
      @total_mes05_column = 0
      @total_mes06_column = 0
      @total_mes07_column = 0
      @total_mes08_column = 0
      @total_mes09_column = 0
      @total_mes10_column = 0
      @total_mes11_column = 0
      @total_mes12_column = 0
      


      lcCli = @customerpayment_rpt.first.customer_id
      $lcCliName = ""
    

     for  customerpayment_rpt in @customerpayment_rpt

        if lcCli == customerpayment_rpt.customer_id 

          $lcCliName = customerpayment_rpt.customer.name  
      
          if customerpayment_rpt.year_month.to_f <= 201612
            @total_anterior = @total_anterior + customerpayment_rpt.balance.round(2)          
          end             

          if customerpayment_rpt.year_month == '201701'
            @total_mes01 = @total_mes01 + customerpayment_rpt.balance.round(2)        
          end   

          if customerpayment_rpt.year_month == '201702' 
            @total_mes02 = @total_mes02 + customerpayment_rpt.balance.round(2)        
          end 
            
          if customerpayment_rpt.year_month == '201703'   
            @total_mes03 = @total_mes03 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201704'     
            @total_mes04 = @total_mes04 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201705'       
            @total_mes05 = @total_mes05 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201706'
            @total_mes06 = @total_mes06 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201707' 
            @total_mes07 = @total_mes07 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201708'   
            @total_mes08 = @total_mes08 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201709'     
            @total_mes09 = @total_mes09 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201710'       
            @total_mes10 = @total_mes10 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201711'   
            @total_mes11 = @total_mes11 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201712'     
            @total_mes12 = @total_mes12 + customerpayment_rpt.balance.round(2)        
          end   
        else
          
            @total_cliente = @total_anterior+
            @total_mes01+
            @total_mes02+
            @total_mes03+
            @total_mes04+
            @total_mes05+
            @total_mes06+
            @total_mes07+
            @total_mes08+
            @total_mes09+
            @total_mes10+
            @total_mes11+
            @total_mes12
            
            row = []
            row << nroitem.to_s        
            row << $lcCliName
            row << sprintf("%.2f",@total_anterior.to_s)
            row << sprintf("%.2f",@total_mes01.to_s)
            row << sprintf("%.2f",@total_mes02.to_s)
            row << sprintf("%.2f",@total_mes03.to_s)
            row << sprintf("%.2f",@total_mes04.to_s)
            row << sprintf("%.2f",@total_mes05.to_s)
            row << sprintf("%.2f",@total_mes06.to_s)
            row << sprintf("%.2f",@total_mes07.to_s)
            row << sprintf("%.2f",@total_mes08.to_s)
            row << sprintf("%.2f",@total_mes09.to_s)
            row << sprintf("%.2f",@total_mes10.to_s)
            row << sprintf("%.2f",@total_mes11.to_s)
            row << sprintf("%.2f",@total_mes12.to_s)
            row << sprintf("%.2f",@total_cliente.to_s)

            table_content << row            
            ## TOTAL XMES GENERAL
            @total_anterior_column = @total_anterior_column + @total_anterior
            @total_mes01_column = @total_mes01_column +@total_mes01
            @total_mes02_column = @total_mes02_column +@total_mes02
            @total_mes03_column = @total_mes03_column +@total_mes03
            @total_mes04_column = @total_mes04_column +@total_mes04
            @total_mes05_column = @total_mes05_column +@total_mes05
            @total_mes06_column = @total_mes06_column +@total_mes06
            @total_mes07_column = @total_mes07_column +@total_mes07
            @total_mes08_column = @total_mes08_column +@total_mes08
            @total_mes09_column = @total_mes09_column +@total_mes09
            @total_mes10_column = @total_mes10_column +@total_mes10
            @total_mes11_column = @total_mes11_column +@total_mes11
            @total_mes12_column = @total_mes12_column +@total_mes12
            @total_cliente = 0 
            ## TOTAL XMES GENERAL

            $lcCliName =customerpayment_rpt.customer.name
            lcCli = customerpayment_rpt.customer_id


            @total_anterior = 0
            @total_mes01 = 0
            @total_mes02 = 0
            @total_mes03 = 0
            @total_mes04 = 0
            @total_mes05 = 0
            @total_mes06 = 0
            @total_mes07 = 0
            @total_mes08 = 0
            @total_mes09 = 0
            @total_mes10 = 0
            @total_mes11 = 0
            @total_mes12 = 0
            @total_cliente = 0 

            if customerpayment_rpt.year_month.to_f <= 201612
            @total_anterior = @total_anterior + customerpayment_rpt.balance.round(2)          
          end             

          if customerpayment_rpt.year_month == '201701'
            @total_mes01 = @total_mes01 + customerpayment_rpt.balance.round(2)        
          end   

          if customerpayment_rpt.year_month == '201702' 
            @total_mes02 = @total_mes02 + customerpayment_rpt.balance.round(2)        
          end 
            
          if customerpayment_rpt.year_month == '201703'   
            @total_mes03 = @total_mes03 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201704'     
            @total_mes04 = @total_mes04 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201705'       
            @total_mes05 = @total_mes05 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201706'
            @total_mes06 = @total_mes06 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201707' 
            @total_mes07 = @total_mes07 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201708'   
            @total_mes08 = @total_mes08 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201709'     
            @total_mes09 = @total_mes09 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201710'       
            @total_mes10 = @total_mes10 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201711'   
            @total_mes11 = @total_mes11 + customerpayment_rpt.balance.round(2)        
          end 
          if customerpayment_rpt.year_month == '201712'     
            @total_mes12 = @total_mes12 + customerpayment_rpt.balance.round(2)        
          end   

          nroitem = nroitem + 1 



        end 
         @total_general = @total_general + customerpayment_rpt.balance.round(2)
       end   

      #fin for
          #ultimo cliente 

          @total_cliente = @total_anterior+
          @total_mes01+
          @total_mes02+
          @total_mes03+
          @total_mes04+
          @total_mes05+
          @total_mes06+
          @total_mes07+
          @total_mes08+
          @total_mes09+
          @total_mes10+
          @total_mes11+
          @total_mes12
            @total_anterior_column = @total_anterior_column + @total_anterior
            @total_mes01_column = @total_mes01_column +@total_mes01
            @total_mes02_column = @total_mes02_column +@total_mes02
            @total_mes03_column = @total_mes03_column +@total_mes03
            @total_mes04_column = @total_mes04_column +@total_mes04
            @total_mes05_column = @total_mes05_column +@total_mes05
            @total_mes06_column = @total_mes06_column +@total_mes06
            @total_mes07_column = @total_mes07_column +@total_mes07
            @total_mes08_column = @total_mes08_column +@total_mes08
            @total_mes09_column = @total_mes09_column +@total_mes09
            @total_mes10_column = @total_mes10_column +@total_mes10
            @total_mes11_column = @total_mes11_column +@total_mes11
            @total_mes12_column = @total_mes12_column +@total_mes12
          
            row = []
            row << nroitem.to_s        
            row << customerpayment_rpt.customer.name  
            row << sprintf("%.2f",@total_anterior.to_s)
            row << sprintf("%.2f",@total_mes01.to_s)
            row << sprintf("%.2f",@total_mes02.to_s)
            row << sprintf("%.2f",@total_mes03.to_s)
            row << sprintf("%.2f",@total_mes04.to_s)
            row << sprintf("%.2f",@total_mes05.to_s)
            row << sprintf("%.2f",@total_mes06.to_s)
            row << sprintf("%.2f",@total_mes07.to_s)
            row << sprintf("%.2f",@total_mes08.to_s)
            row << sprintf("%.2f",@total_mes09.to_s)
            row << sprintf("%.2f",@total_mes10.to_s)
            row << sprintf("%.2f",@total_mes11.to_s)
            row << sprintf("%.2f",@total_mes12.to_s)
            row << sprintf("%.2f",@total_cliente.to_s)

            table_content << row            
            


        row = []
         row << ""       
         row << " TOTAL GENERAL => "
         row << sprintf("%.2f",@total_anterior_column.to_s)
         row << sprintf("%.2f",@total_mes01_column.to_s)
         row << sprintf("%.2f",@total_mes02_column.to_s)
         row << sprintf("%.2f",@total_mes03_column.to_s)
         row << sprintf("%.2f",@total_mes04_column.to_s)
         row << sprintf("%.2f",@total_mes05_column.to_s)
         row << sprintf("%.2f",@total_mes06_column.to_s)
         row << sprintf("%.2f",@total_mes07_column.to_s)
         row << sprintf("%.2f",@total_mes08_column.to_s)
         row << sprintf("%.2f",@total_mes09_column.to_s)
         row << sprintf("%.2f",@total_mes10_column.to_s)
         row << sprintf("%.2f",@total_mes11_column.to_s)
         row << sprintf("%.2f",@total_mes12_column.to_s)
         row << sprintf("%.2f",@total_general.to_s)
         
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
                                          
                                        end                                          
      pdf.move_down 10      
      pdf

    end


    def build_pdf_footer_rpt2(pdf)

        subtotals = []
        taxes = []
        totals = []
        services_subtotal = 0
        services_tax = 0
        services_total = 0

        
        
        pdf.text "" 

        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end


  def rpt_ccobrar5_pdf

    @company=Company.find(params[:id])      
    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]
    @tipomoneda = params[:moneda_id]

    @company.actualiza_purchase_monthyear
    @customerpayment_rpt = @company.get_customer_payments2(@tipomoneda)
      
    Prawn::Document.generate("app/pdf_output/rpt_customerpayment2.pdf") do |pdf|        

        pdf.start_new_page(:size => "A4", :layout => :landscape)
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt2(pdf)
        pdf = build_pdf_body_rpt2(pdf)
        build_pdf_footer_rpt2(pdf)
        $lcFileName =  "app/pdf_output/rpt_customerpayment2.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  
  end

##
## 
##

 
  def build_pdf_header(pdf)

    
      pdf.image "#{Dir.pwd}/public/images/logo.png", :width => 160
        
      pdf.move_down 6
        
      pdf.move_down 4
      #pdf.text supplier.street, :size => 10
      #pdf.text supplier.district, :size => 10
      #pdf.text supplier.city, :size => 10
      pdf.move_down 4

      pdf.bounding_box([325, 725], :width => 200, :height => 80) do
        pdf.stroke_bounds
        pdf.move_down 15
        pdf.font "Helvetica", :style => :bold do
          pdf.text "R.U.C: 20424092941", :align => :center
          pdf.text "COMPROBANTE DE PAGO", :align => :center
          pdf.text "#{@supplierpayment.code}", :align => :center,
                                 :style => :bold
          
        end
      end
      pdf.move_down 10
      pdf 
  end   

  def build_pdf_body(pdf)
    
    pdf.text "__________________________________________________________________________", :size => 13, :spacing => 4
    pdf.text " ", :size => 13, :spacing => 4
    pdf.font "Helvetica" , :size => 8

    
          data =[  [$lcEntrega1,""],
               [$lcEntrega3,$lcEntrega5],
               [$lcEntrega4,$lcEntrega6]]

           
            pdf.text " "
            pdf.table(data,:cell_style=> {:border_width=>0,:width=> 270,:height => 20 })
            pdf.move_down 10          
          


      headers = []
      table_content = []

      SupplierPayment::TABLE_HEADERS.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

      row=[]
      row<< "0"
      row<< @supplierpayment.get_document(@supplierpayment.document_id)    
      row<< @supplierpayment.documento    
      row<< @supplierpayment.nrooperacion 
      row<< @supplierpayment.operacion   
      row<< @supplierpayment.total.to_s    
      table_content << row     

       for  product in @supplierpayment.get_payments() 
            row = []
            row << nroitem.to_s          
            row << product.get_document(product.document_id)
            row << product.documento    
            row << product.get_supplier(product.supplier_id)
            row << "" 
            row << product.total.to_s

            table_content << row
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
                                          columns([4]).align=:right 
                                          columns([5]).align=:right 
                                        end

      pdf.move_down 10  
      pdf

    end


    def build_pdf_footer(pdf)

   $lcAccount= @supplierpayment.bank_acount.number
   $lcBanco =@supplierpayment.get_banco(@supplierpayment.bank_acount.bank_id)  
   $lcCheque =@supplierpayment.get_document(@supplierpayment.document_id)+ "-"+@supplierpayment.documento    
      
   
      data =[  ["BANCO","NRO.CUENTA","OPERACION :","GIRADO :","MONEDA : ","T/C."],
               [$lcBanco,$lcAccount,$lcCheque,$lcFecha1,$lcMon,"0.00"]]

            pdf.move_down 100
            pdf.text " "
            pdf.table(data,:cell_style=> {:border_width=>1, :width=> 90,:height => 20 })
            pdf.move_down 10          
          

        pdf.text ""
        pdf.text "" 
        pdf.text "CONCEPTO : #{@supplierpayment.descrip}", :size => 8, :spacing => 4

        
       data =[ ["Procesado por ","V.B.Contador","V.B.Gerente Fin.","V.B. Gerente Gral."],
               [":",":",":",":"],
               [":",":",":",":"],
               ["Fecha:","Fecha:","Fecha:","Fecha:"] ]

           
            pdf.text " "
            pdf.table(data,:cell_style=> {:border_width=>1} , :width => pdf.bounds.width)
            pdf.move_down 10          
   
        
        
        pdf.table invoice_summary, {
        :position => :right,
        :cell_style => {:border_width => 1},
        :width => pdf.bounds.width/2
        } do
        columns([0]).font_style = :bold
        columns([1]).align = :right        
        end
    

        pdf.bounding_box([0, 20], :width => 538, :height => 50) do        
        pdf.draw_text "Company: #{@supplierpayment.company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom ]

      end

      pdf
      
  end
# ---------------------------------------------------------------------------------------------------

#  REPORTE DE CANCELACIONES 

# ---------------------------------------------------------------------------------------------------


  def build_pdf_header_rpt3(pdf)
      pdf.font "Helvetica" , :size => 6
      

     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers.length, invoice_headers.length, 0].max
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

 def build_pdf_body_rpt3(pdf)
    
    pdf.text "Listado de Cancelaciones Proveedores:    Fecha "+@fecha1.to_s+ " Mes : "+@fecha2.to_s , :size => 11 
    pdf.text ""
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []
      total_general = 0
      total_factory = 0

      SupplierPayment::TABLE_HEADERS2.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end
      table_content << headers
      nroitem = 1

       for  customerpayment_rpt in @customerpayment_rpt

        #@fechacobro = customerpayment_rpt.fecha1
        $lcDocumento = customerpayment_rpt.nrooperacion << customerpayment_rpt.operacion   
        row = []
         row << nroitem.to_s
         row << customerpayment_rpt.code
         row << customerpayment_rpt.fecha1.strftime("%d/%m/%Y")         
         row << customerpayment_rpt.get_moneda(customerpayment_rpt.bank_acount.bank_id)   
         row << customerpayment_rpt.get_document(customerpayment_rpt.document_id)    
         row << $lcDocumento 
         row << customerpayment_rpt.supplier.ruc
         row << customerpayment_rpt.supplier.name    
         row << " "
         row << customerpayment_rpt.total    
         table_content << row
                
        @customerdetails =  customerpayment_rpt.get_payments()

        if @customerdetails

           for  productItem in  @customerdetails
                
                row = []
                row <<  nroitem.to_s
                row << " "
                row << " "
                row << " "
                row <<  productItem.get_document(productItem.document_id)   
                row <<  productItem.documento
                row <<  productItem.get_supplier_ruc(productItem.supplier_id)
                row <<  productItem.get_supplier(productItem.supplier_id)
                row <<  sprintf("%.2f",productItem.total.to_s)
                row << " "

                table_content << row

                nroitem=nroitem + 1
             
            end
        end 

       end  
      
      row =[]
      row << ""
      row << ""
      row << ""
      row << ""
      row << ""
      row << ""
      row << ""
      row << "TOTALES => "
      row << sprintf("%.2f",@total_soles.to_s)
      row << sprintf("%.2f",@total_dolares.to_s)                    
      
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
                                          columns([5]).align=:left
                                          columns([6]).align=:left
                                          columns([7]).align=:left 
                                          columns([8]).align=:right
                                          columns([9]).align=:right
                                          columns([10]).align=:right
                                        end                                          
      pdf.move_down 10      
      pdf
      
    end


    def build_pdf_footer_rpt3(pdf)      
        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]
    end
    pdf
      
end



  def rpt_cpagar4_pdf

    @company=Company.find(params[:id])      
    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]
    @tipomoneda = params[:moneda_id]

    @customerpayment_rpt = @company.get_supplier_payments0(@fecha1,@fecha2)
    @total_soles   = @company.get_paymentsD_day_value(@fecha1,@fecha2,"total")
    @total_dolares = @company.get_paymentsC_day_value(@fecha1,@fecha2,"total")
      
    Prawn::Document.generate("app/pdf_output/rpt_supplierpayment2.pdf") do |pdf|        
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt3(pdf)
        pdf = build_pdf_body_rpt3(pdf)
        build_pdf_footer_rpt3(pdf)
        $lcFileName =  "app/pdf_output/rpt_supplierpayment2.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  
  end

def rpt_cpagar5_pdf

    @company=Company.find(params[:id])      
    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]
    @tipomoneda = params[:moneda_id]

    
    @customerpayment_rpt = @company.get_supplier_payments0(@fecha1,@fecha2)
    @total_soles   = @company.get_paymentsD_day_value(@fecha1,@fecha2,"total")
    @total_dolares = @company.get_paymentsC_day_value(@fecha1,@fecha2,"total")
      
    Prawn::Document.generate("app/pdf_output/rpt_supplierpayment2.pdf") do |pdf|        
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt3(pdf)
        pdf = build_pdf_body_rpt3(pdf)
        build_pdf_footer_rpt3(pdf)
        $lcFileName =  "app/pdf_output/rpt_supplierpayment2.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  
  end




  # Export supplierpayment to PDF
  def pdf
    @supplierpayment = SupplierPayment.find(params[:id])
    company =@supplierpayment.company_id
    @company =Company.find(company)
  

     $lcCli  = @supplierpayment.supplier.name
     $lcdir1 = @supplierpayment.supplier.address1
     
     $lcFecha1= @supplierpayment.fecha1.strftime("%d/%m/%Y") 
     $lcMon   = @supplierpayment.get_moneda(@supplierpayment.bank_acount.bank_id)
     $lcPay= ""
     $lcSubtotal=0
     $lcIgv=0
     $lcTotal=sprintf("%.2f",@supplierpayment.total)

     $lcDetracion=0
     $lcAprobado= @supplierpayment.get_processed 


    $lcEntrega1 =  "PAGUESE A NOMBRE :"+$lcCli 
    $lcEntrega2 =  $lcCli
    $lcEntrega3 =  "NOMBRE DEL PROVEEDOR: "
    $lcEntrega4 =  $lcCli
    $lcEntrega5 =  "FECHA COMPRO:"
    $lcEntrega6 =  $lcFecha1

    Prawn::Document.generate("app/pdf_output/#{@supplierpayment.id}.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header(pdf)
        pdf = build_pdf_body(pdf)
        build_pdf_footer(pdf)
        $lcFileName =  "app/pdf_output/#{@supplierpayment.id}.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  

  end
  
  # Process an supplierpayment
  def do_process

    @supplierpayment = SupplierPayment.find(params[:id])
    @supplierpayment[:processed] = "1"
    
    @supplierpayment.process
    
    flash[:notice] = "The supplierpayment order has been processed."
    redirect_to @supplierpayment
  end
  # Process an supplierpayment
  def do_anular
    @supplierpayment = SupplierPayment.find(params[:id])
    @supplierpayment[:processed] = "2"
    
    @supplierpayment.anular 
    
    flash[:notice] = "The supplierpayment order has been anulado."
    redirect_to @supplierpayment
  end
  
  # Do send supplierpayment via email
  def do_email
    @supplierpayment = SupplierPayment.find(params[:id])
    @email = params[:email]
    
    Notifier.supplierpayment(@email, @supplierpayment).deliver
      
    flash[:notice] = "The supplierpayment has been sent successfully."
    redirect_to "/supplierpayments/#{@supplierpayment.id}"
  end

  def do_grabar_ins
    
    @supplierpayment = SupplierPayment.find(params[:id])

    @company = @supplierpayment.company
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @suppliers = @company.get_suppliers()
    @payments = @company.get_payments()    
    @monedas  = @company.get_monedas()    


    ##Cerrar la order de servicio
    @supplierpayment[:processed]='3'
    documento =  @supplierpayment[:documento]
    documento_id =  params[:documento_id]
    
    if(params[:ac_documento] and params[:ac_documento] != "")
     
    else
        puts documento
    end
    
    submision_hash = {"document_id" => params[:ac_document_id],
                       "documento"  => params[:ac_documento] }

    respond_to do |format| 
    if  @supplierpayment.update_attributes(submision_hash)
        @supplierpayment.cerrar()
        
        format.html { redirect_to(@supplierpayment, :notice => 'Orden de servicio actualizada  ') }        
        format.xml  { head :ok }

      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplierpayment.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # Send supplierpayment via email
  def email
    @supplierpayment = SupplierPayment.find(params[:id])
    @company = @supplierpayment.company
  end
  
  # List items
  def list_items
    
    @company = Company.find(params[:company_id])
    items = params[:items]
    items = items.split(",")
    items_arr = []
    @products = []
    @total_pago=0
    @importe_total=0
    i = 0

    for item in items
      if item != ""
        parts = item.split("|BRK|")        
        id = parts[0]        
        price = parts[1]                
        product = Purchase.find(id.to_i)
        product[:tax1] = i        
        product[:price_with_tax] = price.to_f              
        total = product[:price_with_tax]                  
        product[:total_amount] = total
        @total_pago = @total_pago + total       
        @products.push(product)
      end
      
      i += 1
   end
    
    render :layout => false
  end
  
 def ac_facturas
    @docs = Purchase.where(["company_id =  ? and (documento iLIKE ? )",params[:company_id], "%" + params[:q] + "%"])   
    render :layout => false
  end
  # Autocomplete for documents
  def ac_documentos
    @docs = Purchase.where(["company_id = ? AND (documento iLIKE ? )", params[:company_id], "%" + params[:q] + "%"])   
    render :layout => false
  end
  
  # Autocomplete for products
  def ac_suppliers
    @suppliers = Supplier.where(["company_id = ? AND (ruc iLIKE ? OR name iLIKE ?)", params[:company_id], "%" + params[:q] + "%", "%" + params[:q] + "%"])   
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
  
  # Autocomplete for suppliers
  def ac_suppliers
    @suppliers = Supplier.where(["company_id = ? AND (name iLIKE ?)", params[:company_id], "%" + params[:q] + "%"])

    render :layout => false
  end
  
  # Show supplierpayments for a company
  
  def list_supplierpayments
    @company = Company.find(params[:company_id])
    @pagetitle = "#{@company.name} - supplierpayments"
    @filters_display = "block"
    @bank_acounts = @company.get_bank_acounts()
    
    
    @locations = Location.where(company_id: @company.id).order("name ASC")
    @divisions = Division.where(company_id: @company.id).order("name ASC")
    
    if(params[:location] and params[:location] != "")
      @sel_location = params[:location]
    end
    
    if(params[:division] and params[:division] != "")
      @sel_division = params[:division]
    end
  
    if(@company.can_view(current_user))
      if(params[:ac_documentos] and params[:ac_documentos] != "")
        @supplier = supplier.find(:first, :conditions => {:company_id => @company.id, :name => params[:ac_supplier].strip})
        
        if @supplier
          @supplierpayments = supplierpayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :supplier_id => @supplier.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any supplierpayments for that supplier."
          redirect_to "/companies/supplierpayments/#{@company.id}"
        end
      elsif(params[:supplier] and params[:supplier] != "")
        @supplier = Supplier.find(params[:supplier])
        
        if @supplier
          @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :supplier_id => @supplier.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any supplierpayments for that supplier."
          redirect_to "/companies/supplierpayments/#{@company.id}"
        end
      elsif(params[:location] and params[:location] != "" and params[:division] and params[:division] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location], :division_id => params[:division]}, :order => "id DESC")
      elsif(params[:location] and params[:location] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location]}, :order => "id DESC")
      elsif(params[:division] and params[:division] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :division_id => params[:division]}, :order => "id DESC")
      else
        if(params[:q] and params[:q] != "")
          fields = ["description", "comments", "code"]

          q = params[:q].strip
          @q_org = q

          query = str_sql_search(q, fields)

          @supplierpayments = SupplierPayment.paginate(:page => params[:page], :order => 'id DESC', :conditions => ["company_id = ? AND (#{query})", @company.id])
        else
          @supplierpayments = SupplierPayment.where(company_id:  @company.id).order("id DESC").paginate(:page => params[:page])
          @filters_display = "none"
        end
      end
    else
      errPerms()
    end
  end
  
  # GET /supplierpayments
  # GET /supplierpayments.xml
  def index
    @companies = Company.where(user_id: current_user.id).order("name")
    @path = 'supplierpayments'
    @pagetitle = "supplierpayments"
  end

  # GET /supplierpayments/1
  # GET /supplierpayments/1.xml
  def show
    @supplierpayment = SupplierPayment.find(params[:id])

    @company = Company.find(@supplierpayment.company_id)

    @bank_acounts = @company.get_bank_acounts()        
    @monedas  = @company.get_monedas()
    @documents  = @company.get_documents()
    
    @supplierpayment_details = @supplierpayment.supplierpayment_details

  end

  # GET /supplierpayments/new
  # GET /supplierpayments/new.xml
  
  def new
    @pagetitle = "Nueva Orden"
    @action_txt = "Create"
    
    @supplierpayment = SupplierPayment.new
    @supplierpayment[:code] = "#{generate_guid9()}"
    @supplierpayment[:processed] = false
    @supplierpayment[:fecha1] =  Date.today

    
    @company = Company.find(1)
    @supplierpayment.company_id = @company.id
    banco_id = params[:banco_id]
    puts "banco..."
    puts banco_id
    @supplierpayment[:documento] =  @supplierpayment.ultimo_cheque(banco_id) 
  
    @supplierpayment[:total] = 0.00

    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @suppliers = @company.get_suppliers()
    @conceptos = Concept.all.order(:descrip )
    
    @bank_acounts = @company.get_bank_acount_by(banco_id)        
    @monedas  = @company.get_monedas()
    @documents  = @company.get_documents_cheque()
  
    @ac_user = getUsername()
    @supplierpayment[:user_id] = getUserId()
  
  end

  # GET /supplierpayments/1/edit
  def edit
    @pagetitle = "Edit supplierpayment"
    @action_txt = "Update..."
    
    @supplierpayment = SupplierPayment.find(params[:id])
    @company = @supplierpayment.company
    @ac_supplier = @supplierpayment.supplier.name
    @ac_user = @supplierpayment.user.username
    @suppliers = @company.get_suppliers()
    @servicebuys  = @company.get_servicebuys()
    @payments = @company.get_payments()
    @monedas  = @company.get_monedas()
    @bank_acounts = @company.get_bank_acounts()       
     @documents  = @company.get_documents()
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
  end

  # POST /supplierpayments
  # POST /supplierpayments.xml
  def create
    @pagetitle = "Nueva Orden"
    @action_txt = "Create"
    
    items = params[:items].split(",")
    
    @supplierpayment = SupplierPayment.new(supplierpayment_params)    
    @company = Company.find(params[:supplier_payment][:company_id])
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @suppliers = @company.get_suppliers()
    @bank_acounts = @company.get_bank_acounts()        
    @monedas     = @company.get_monedas()
    @documents  = @company.get_documents()

    @supplierpayment.processed='1'
        
    @supplierpayment.user_id=@current_user.id 

    respond_to do |format|
      if @supplierpayment.save
        # Create products for kit
        @supplierpayment.add_products(items)
        
        # Check if we gotta process the supplierpayment
        @supplierpayment.process()
        @supplierpayment.correlativo 
        
        format.html { redirect_to(@supplierpayment, :notice => 'supplierpayment was successfully created.') }
        format.xml  { render :xml => @supplierpayment, :status => :created, :location => @supplierpayment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @supplierpayment.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /supplierpayments/1
  # PUT /supplierpayments/1.xml
  def update
    @pagetitle = "Editar Orden"
    @action_txt = "Update"
    
    items = params[:items].split(",")
    
    @supplierpayment = SupplierPayment.find(params[:id])
    @company = @supplierpayment.company
    
    if(params[:ac_supplier] and params[:ac_supplier] != "")
      @ac_supplier = params[:ac_supplier]
    else
      @ac_supplier = @supplierpayment.supplier.name
    end
    
    @products_lines = @supplierpayment.products_lines
    
    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @suppliers = @company.get_suppliers()
    @payments = @company.get_payments()
    @servicebuys  = @company.get_servicebuys()
    @monedas  = @company.get_monedas()
    
    @supplierpayment[:subtotal] = @supplierpayment.get_subtotal(items)
    @supplierpayment[:tax] = @supplierpayment.get_tax(items, @supplierpayment[:supplier_id])
    @supplierpayment[:total] = @supplierpayment[:subtotal] + @supplierpayment[:tax]

    respond_to do |format|
      if @supplierpayment.update_attributes(params[:supplierpayment])
        # Create products for kit
        @supplierpayment.delete_products()
        @supplierpayment.add_products(items)
        
        # Check if we gotta process the supplierpayment
        @supplierpayment.process()
        
        format.html { redirect_to(@supplierpayment, :notice => 'supplierpayment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @supplierpayment.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /supplierpayments/1
  # DELETE /supplierpayments/1.xml
  def destroy
    @supplierpayment = SupplierPayment.find(params[:id])
    company_id = @supplierpayment[:company_id]
    @supplierpayment.destroy

    respond_to do |format|
      format.html { redirect_to("/companies/supplier_payments/" + company_id.to_s) }
    end
  end

  def client_data_headers

    #{@supplierpayment.description}
      client_headers  = [["Proveedor :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]      
      client_headers
  end

  def invoice_headers            
      invoice_headers  = [["Fecha Compro. : ",$lcFecha1]]
      invoice_headers <<  ["Tipo de moneda : ", $lcMon]    
      invoice_headers
  end

  def invoice_summary
      invoice_summary = []
      invoice_summary << ["RECIBI CONFORME ",""]
      invoice_summary << ["Fecha  :",""]
      invoice_summary << ["D.N.I. :","Firma"]
      invoice_summary << ["Nombre y Apellidos :",""]
      invoice_summary
  end




  # Export supplierpayment to PDF
  def rpt_purchases_all
    @company=Company.find(params[:id])      
    
    @fecha1=params[:fecha1]
    @fecha2=params[:fecha2]
    @moneda = params[:moneda_id]
      
    @purchases_all_rpt = @company.get_purchases_by_day_detalle(@fecha1,@fecha2)  
   
    @rpt = "rpt_#{generate_guid()}"


    Prawn::Document.generate "app/pdf_output/#{@rpt}.pdf"  ,:size=> "A4",:margin => [20,20,5,20] do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt(pdf)        
        pdf = build_pdf_body_rpt(pdf)
        build_pdf_footer_rpt(pdf)
        $lcFileName =  "app/pdf_output/#{@rpt}.pdf"      
    end     


    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  end



 def rpt_compras_01 
  
    @company=Company.find(1)      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]

    @compras  = @company.get_purchases_by_day_detalle(@fecha1,@fecha2)  
    @purchases_all_1 = @company.get_purchases_by_day2(@fecha1,@fecha2,"2")
    @purchases_all_2 = @company.get_purchases_by_day2(@fecha1,@fecha2,"1")
    @purchase = Purchase.first
      
    case params[:print]
      when "PDF" then render  pdf: "rpt_compras ",template: "supplier_payments/rpt_compras_01.pdf.erb",locals: {:contrato => @contratos_rpt}
      when "Excel" then render xlsx: 'rpt_compras_01'
      else render action: "index"
    end
    
  end


 def rpt_contrato1_pdf 
  
    @company=Company.find(1)  

    @cliente_check = params[:check_cliente]   
    @medio_check = params[:check_medio]   
    @anio = params[:year]    
    @fecha1 = params[:fecha1]   
    @fecha2 = params[:fecha2]   
    puts "rpt contrato "
    puts @fecha1 
    puts @fecha1 

    @contratos_rpt = @company.get_contratos_medio(@fecha1,@fecha2)
      
    case params[:print]
      when "PDF"   then 

      begin 
        render  pdf: "rpt_contratos",template: "supplier_payments/rpt_contrato_01.pdf.erb",locals: {:contrato => @contratos_rpt,:fecha1=> @fecha1, :fecha2=> @fecha2 },
         :header => {
           :spacing => 5,
                           :html => {
                           :template => 'layouts/pdf-header3.html', 
                           right: '[page] of [topage]'
                  }
               },

               :footer => { :html => { template: 'layouts/pdf-footers.html' }       }  ,   
               :margin => {bottom: 35} 
                
       end   


      when "Excel" then render xlsx: 'rpt_contratos_1'
      else render action: "index"
    end
    
  end




 def rpt_cpagar6_pdf 
  
    @company=Company.find(1)      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]

    @conceptos = Concept.all 
    @compras  = @company.get_purchases_by_day_detalle(@fecha1,@fecha2)  
    @purchases_all_1 = @company.get_purchases_by_day2(@fecha1,@fecha2,"1")
    @purchases_all_2 = @company.get_purchases_by_day2(@fecha1,@fecha2,"2")
    @purchase = Purchase.first
      
    case params[:print]
      when "PDF" then render  pdf: "rpt_cpagar6_pdf",template: "supplier_payments/rpt_cpagar6_pdf.erb",locals: {:contrato => @contratos_rpt}
      when "Excel" then render xlsx: 'rpt_cpagar6_pdf'
      else render action: "index"
    end
    
  
  end


 def rpt_concilia_1 
  
    @company=Company.find(1)      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]
    @banco = params[:bank_acount_id]
    
    a=    BankAcount.find(@banco)

    @banco_name   =  a.bank.name
    @banco_moneda =  a.moneda.description 
    @banco_cuenta =  a.number

    puts "concilia"
    puts @fecha1
    puts @fecha2
    puts @banco 

    
  # @saldo_banco     = @company.get_statamenacount_by_day(@fecha1,@fecha2,@banco)
  # @detalle_cheques = @company.get_statamenacount_by_days(@fecha1,@fecha2,@banco)
    @cabecera = @company.get_concilia_by_day(@fecha1,@fecha2,@banco)
    @saldo_banco = @cabecera.saldo_inicial
    @concilia_id = @cabecera.id   
    @detalle_cheques = @company.get_concilia_by_days(@cabecera.id) 
    
    case params[:print]
      when "PDF"   then render  pdf: "rpt_concilia",template: "supplier_payments/rpt_concilia_1.pdf.erb",locals: {:supplierpayments => @detalle_cheques},
      :orientation      => 'Portrait',
         :header => {
           :spacing => 5,
                           :html => {
                     :template => 'layouts/pdf-headers.html',
                           right: '[page] of [topage]'
                  }                  
               } ,

          :footer => { :html => { template: 'layouts/pdf-footers.html' }       }  ,   
          :margin => {bottom: 15} 


      when "Excel" then render xlsx: 'rpt_concilia_1'
      else render action: "index"
    end
    
  
  end



  def receive
    @supplierpayment = SupplierPayment.find(params[:id])
    @supplier = @supplierpayment.supplier
    @company = Company.find(@supplierpayment.company_id)
    @documents =@company.get_documents()
  
  end


  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers
  end

  def invoice_headers_rpt            
      invoice_headers  = [["Fecha : ",$lcHora]]    
      invoice_headers
  end
def list_receive_supplierpayments
    @company = Company.find(params[:company_id])
    @pagetitle = "#{@company.name} - Orden Compra"
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
      if(params[:ac_supplier] and params[:ac_supplier] != "")
        @supplier = supplier.find(:first, :conditions => {:company_id => @company.id, :name => params[:ac_supplier].strip})
        
        if @supplier
          @supplierpayments = Seriveorder.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :supplier_id => @supplier.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any supplierpayments for that supplier."
          redirect_to "/companies/supplierpayments/#{@company.id}"
        end
      elsif(params[:supplier] and params[:supplier] != "")
        @supplier = supplier.find(params[:supplier])
        
        if @supplier
          @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :supplier_id => @supplier.id}, :order => "id DESC")
        else
          flash[:error] = "We couldn't find any supplierpayments for that supplier."
          redirect_to "/companies/supplierpayments/#{@company.id}"
        end
      elsif(params[:location] and params[:location] != "" and params[:division] and params[:division] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location], :division_id => params[:division]}, :order => "id DESC")
      elsif(params[:location] and params[:location] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :location_id => params[:location]}, :order => "id DESC")
      elsif(params[:division] and params[:division] != "")
        @supplierpayments = SupplierPayment.paginate(:page => params[:page], :conditions => {:company_id => @company.id, :division_id => params[:division]}, :order => "id DESC")
      else
        if(params[:q] and params[:q] != "")
          fields = ["description", "comments", "code"]

          q = params[:q].strip
          @q_org = q

          query = str_sql_search(q, fields)

          @supplierpayments = SupplierPayment.paginate(:page => params[:page], :order => 'id DESC', :conditions => ["company_id = ? AND (#{query})", @company.id])
        else
          @supplierpayments = SupplierPayment.where(company_id:  @company.id, :processed => "1").order("id DESC").paginate(:page => params[:page])
          @filters_display = "none"
        end
      end
    else
      errPerms()
    end
  end

  # reporte completo
  def build_pdf_header_rpt(pdf)
      pdf.font "Helvetica" , :size => 6
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

    max_rows = [client_data_headers.length, invoice_headers.length, 0].max
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
    
    pdf.text "COMPRAS : Desde "+@fecha1.to_s+ " Hasta : "+@fecha2.to_s , :size => 11 ,:align => :center
    pdf.text ""
    pdf.font "Helvetica" , :size => 6
    pdf.font_families.update("Open Sans" => {
          :normal => "app/assets/fonts/OpenSans-Regular.ttf",
          :italic => "app/assets/fonts/OpenSans-Italic.ttf",
        })

        pdf.font "Open Sans",:size => 6 
    
      headers = []
      table_content = []

      SupplierPayment::TABLE_HEADERS1.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end
      table_content << headers
      nroitem=1

       lcMoneda = @purchases_all_rpt.first.moneda_id
       lcDocumento = @purchases_all_rpt.first.document_id
       a = @purchases_all_rpt.first
       
            row = []
           
            row << "MONEDA  :"
            row << a.moneda.description 
            row << a.moneda.symbol
            row << "" 
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row
            
       
            row = []
            row << ""
            row << "DOCUMENTO :"
            row << a.document.description 
            row << ""
            row << ""
            row << ""
            row << ""
             row << ""
            
            table_content << row
            
       
       for  product in @purchases_all_rpt
      
        if lcMoneda == product.moneda_id
          if lcDocumento == product.document_id
            row = []
            row << nroitem.to_s
            row << product.supplier.ruc 
            row << product.supplier.name  
            row << product.documento
            row << product.date1.strftime("%d/%m/%Y")

            row <<  sprintf("%.2f",product.inafecto.to_s)
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row

            nroitem=nroitem + 1
          else
            totals = []            
            total_cliente_doc_inafecto   = 0
            total_cliente_doc_payable   = 0
            total_cliente_doc_tax   = 0
            total_cliente_doc_total   = 0

            total_cliente_doc_inafecto = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"inafecto")
            total_cliente_doc_payable  = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
            total_cliente_doc_tax      = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
            total_cliente_doc_total    = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << "TOTAL x Tipo Doc => "            
            row << ""
            row << ""
        
            row << sprintf("%.2f",total_cliente_doc_inafecto.to_s)
            row << sprintf("%.2f",total_cliente_doc_payable.to_s)
            row << sprintf("%.2f",total_cliente_doc_tax.to_s)
            row << sprintf("%.2f",total_cliente_doc_total.to_s)
            
            table_content << row
            
            lcDocumento = product.document_id
            
            row = []
            row << ""
            row << "DOCUMENTO :"
            row << product.document.description 
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row
            
            row = []
            row << nroitem.to_s
            row << product.supplier.ruc 
            row << product.supplier.name  
            row << product.documento
            row << product.date1.strftime("%d/%m/%Y")
            row <<  sprintf("%.2f",product.inafecto.to_s)
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row

            nroitem=nroitem + 1
            
          end 
            
        else

            total_cliente_doc_inafecto  = 0
            total_cliente_doc_payable   = 0
            total_cliente_doc_tax       = 0
            total_cliente_doc_total     = 0

            total_cliente_doc_inafecto = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"inafecto")            
            total_cliente_doc_payable  = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
            total_cliente_doc_tax      = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
            total_cliente_doc_total    = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << "TOTAL x Tipo Doc => "   
            row << " "            
            row << ""
            
            row << sprintf("%.2f",total_cliente_doc_inafecto.to_s)
            row << sprintf("%.2f",total_cliente_doc_payable.to_s)
            row << sprintf("%.2f",total_cliente_doc_tax.to_s)
            row << sprintf("%.2f",total_cliente_doc_total.to_s)
            
            table_content << row
          
          
            totals = []            
            total_cliente_moneda_inafecto   = 0
            total_cliente_moneda_payable   = 0
            total_cliente_moneda_tax   = 0
            total_cliente_moneda_total   = 0

            total_cliente_moneda_inafecto = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"inafecto")            
            total_cliente_moneda_payable  = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"payable_amount")
            total_cliente_moneda_tax      = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"tax_amount")
            total_cliente_moneda_total    = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << "TOTAL X MONEDA:"
            row << ""            
            row << ""
            
            row << sprintf("%.2f",total_cliente_moneda_inafecto.to_s)            
            row << sprintf("%.2f",total_cliente_moneda_payable.to_s)
            row << sprintf("%.2f",total_cliente_moneda_tax.to_s)
            row << sprintf("%.2f",total_cliente_moneda_total.to_s)
            
            table_content << row
            
            row = []
            
            row << "MONEDA :"
            row << product.moneda.description 
            row << product.moneda.symbol
            row << ""
             row << ""
            row << ""
            row << ""
            row << ""
            table_content << row
            
          
            row = []
            row << ""
            row << "DOCUMENTO  :"
            row << a.document.description 
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row
            

            row = []
            row << product.documento
            row << product.date1.strftime("%d/%m/%Y")

            row <<  sprintf("%.2f",product.inafecto.to_s)
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row
            
            lcMoneda = product.moneda_id
            lcDocumento = product.document_id
            nroitem=nroitem + 1
        end       
        
        end
            total_cliente_doc_inafecto  = 0            
            total_cliente_doc_payable   = 0
            total_cliente_doc_tax       = 0
            total_cliente_doc_total     = 0

            total_cliente_doc_inafecto = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"inafecto")            
            total_cliente_doc_payable  = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
            total_cliente_doc_tax      = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
            total_cliente_doc_total    = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << "TOTAL x Tipo Doc => "              
            row << ""
            row << ""

          

            row << sprintf("%.2f",total_cliente_doc_inafecto.to_s)            
            row << sprintf("%.2f",total_cliente_doc_payable.to_s)
            row << sprintf("%.2f",total_cliente_doc_tax.to_s)
            row << sprintf("%.2f",total_cliente_doc_total.to_s)
            
            table_content << row
          
            lcDocumento = product.document_id
              
            lcMoneda = @purchases_all_rpt.last.moneda_id

            total_cliente_moneda_inafecto   = 0 
            total_cliente_moneda_payable   = 0
            total_cliente_moneda_tax   = 0
            total_cliente_moneda_total   = 0

            total_cliente_moneda_inafecto = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"inafecto")
            total_cliente_moneda_payable = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"payable_amount")
            total_cliente_moneda_tax     = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"tax_amount")
            total_cliente_moneda_total   = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"total_amount")
            
            row =[]
            row << ""
            row << ""
           
            row << "TOTAL X MONEDA => "            
            row << ""
            row << ""
            row << sprintf("%.2f",total_cliente_moneda_inafecto.to_s)        
            row << sprintf("%.2f",total_cliente_moneda_payable.to_s)
            row << sprintf("%.2f",total_cliente_moneda_tax.to_s)
            row << sprintf("%.2f",total_cliente_moneda_total.to_s)
            
            table_content << row
      
        
      result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width,
                                        :cell_style => {:border_width => 0 ,:height => 15 }

                                        } do 
                                          columns([0]).align=:center

                                          columns([1]).align=:left

                                          columns([2]).align=:left
                                          columns([2]).width= 130 

                                          columns([3]).align=:left
                                          columns([3]).width= 60 

                                          columns([4]).align=:right
                                          columns([4]).width= 50 

                                          columns([5]).align=:right
                                          columns([5]).width= 60

                                          columns([6]).align=:right
                                          columns([6]).width= 60

                                          columns([7]).align=:right
                                          columns([7]).width= 60 

                                          columns([8]).align=:right
                                          columns([8]).width= 60 
                                          
                                          
                                        end                                          
      pdf.move_down 10      
      pdf

    end


    def build_pdf_footer_rpt(pdf)
        
        pdf.text "" 
        pdf.bounding_box([0, 20], :width => 535, :height => 40) do
        pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]

      end

      pdf
      
  end



  # Export serviceorder to PDF
  def rpt_serviceorder_all_pdf
    @company=Company.find(params[:id])      
    
    
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
    

    @serviceorder_rpt = @company.get_services_year_month(@year,@month)  
      
    Prawn::Document.generate("app/pdf_output/rpt_serviceall.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt(pdf)
        pdf = build_pdf_body_rpt(pdf)
        build_pdf_footer_rpt(pdf)
        $lcFileName =  "app/pdf_output/rpt_serviceall.pdf"      
        
    end     

    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName
                
    send_file("#{$lcFileName1}", :type => 'application/pdf', :disposition => 'inline')
  

  end

  def receive
    @serviceorder = Serviceorder.find(params[:id])
    @supplier = @serviceorder.supplier
    @company = Company.find(@serviceorder.company_id)
    @documents =@company.get_documents()

    
  end


  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers
  end

  def invoice_headers_rpt            
      invoice_headers  = [["Fecha : ",$lcHora]]    
      invoice_headers
  end
  def go_bancos 
    lcProcesado='1'

    @banco_id = params[:id]    
    
    @company = Company.find(1)
    
    @supplierpayments = SupplierPayment.where(["bank_acount_id = ?",@banco_id]).order("fecha1 DESC,documento DESC")
    
    return @supplierpayments

  end   

  #**************************************************************************+++++++++++++++++++++
  #
  #**************************************************************************+++++++++++++++++++++

 def contratos_ec01 
  
    $lcxCliente ="1"
    @company=Company.find(1)      
    @mes1 = params[:month]    
    @anio1 = params[:year]

    @mes2 = params[:month2]    
    @anio2 = params[:year2]

    @customer= params[:customer_id]

    lcmonedadolares ="1"
    lcmonedasoles ="2"
    @cliente_check = params[:check_medio]  
    
      @company.get_orden_mesanio

    if @cliente_check == "true"
      @customer = ""
      @customer_name = ""
     
      @ordenes = @company.get_ordenes_eecc(@mes1,@anio1,@mes2,@anio2)

    else
      @customer = params[:customer_id]     
      @customer_name =  @company.get_cliente_name(@customer)
      @ordenes = @company.get_ordenes_eecc_cliente(@mes1,@anio1,@mes2,@anio2,@customer)

    end 

    
      
    case params[:print]
      when "To PDF" then 
       begin 
         render  pdf: "Contratos ",template: "contratos/contrato_rpt2.pdf.erb",locals: {:contrato => @contratos_rpt},
         :header => {
           :spacing => 5,
                           :html => {
                     :template => 'layouts/pdf-header2.html',
                           right: '[page] of [topage]'
                  }
               }
       end   

      when "Excel" then render xlsx: 'contratos_ec_01'
       
      else render action: "index"
    end
  end



  def update_marcas 
     customer = Customer.find(params[:customer_id])
    # map to name and id for use in our options_for_select
     puts customer.id 
     @marcas = Marca.where(customer_id: customer.id)
     @productos = Producto.where(marca_id: @marcas.last.id)
     @versions = Version.where(producto_id: @productos.last.id)
  
  end
  

  def update_productos
    # updates songs based on artist selected
     @marcas = Marca.find(params[:marca_id])
     @productos = Producto.where(marca_id: @marcas.id)
     @versions = Version.where(producto_id: @productos.last.id)
  end

  def update_versions
    # updates songs based on artist selected
    @productos = Producto.find(params[:producto_id])
    @versions = Version.where(producto_id: @productos.id)
  end
  


   def rpt_cadmin_01

      @company = Company.find(1)
     @mes = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]

  
      @medio_check = params[:check_medio]
      @customer_id = params[:customer_id]
      @customer_name =  @company.get_cliente_name(@customer_id)
   
    if @medio_check == "true"
        @medio_id=""
    else
        @medio_id =params[:medio_id]

    end

    puts "detaellll"
    puts @customer
    puts @medio 

    @ordenes = @company.get_ordenes_cliente2b(@mes,@anio,@mes1,@anio1,@customer_id ,@medio_id)

        case params[:print]
      
          when "Generar" then 

            begin 
          
              render xlsx: 'rpt_cadmin_01'

            end

          else render action: "index"
        end



  end

 def rpt_cadmin_02

    @company=Company.find(1)
   @mes = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]

  
    @customer_check = params[:check_cliente]    

    @medio_id = params[:medio_id]
    @medio_name =  @company.get_medio_name(@medio_id)
  
   
    if @customer_check == "true"
        @customer_id = ""
    else
        @customer_id = params[:customer_id]
    end
    puts "medio...."
    puts @medio_name 
    puts "cliente..."
    puts @customer_id 
    puts @fecha1



    @ordenes = @company.get_ordenes_cliente2b(@mes,@anio,@mes1,@anio1,@customer_id ,@medio_id)

        case params[:print]
      
          when "Generar" then 

            begin 
              puts "reporeeeeeee ..."
              render xlsx: 'rpt_cadmin_02'

            end

          else render action: "index"
        end



  end



 def rpt_cadmin_03

    @company=Company.find(1)
    @mes = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]


      @ordenes  = @company.get_ordenes_cliente4(@mes,@anio,@mes1,@anio1)
      @ordenes2 = @company.get_ordenes_cliente5(@mes,@anio,@mes1,@anio1)


        case params[:print]
      
          when "Generar" then 

            begin 
              puts "reporeeeeeee ..."
              render xlsx: 'rpt_cadmin_03'

            end

          else render action: "index"
        end



  end

  

 def rpt_cadmin_04

    @company=Company.find(1)
    @fecha1 = params[:fecha1]
    @fecha2 = params[:fecha2]

    puts "to _date"
    puts @fecha1.to_date
   puts "to _datetime"
    puts @fecha1.to_datetime 
      
  
          
    @ordenes = @company.get_facturas_medios(@fecha1,@fecha2)

        case params[:print]
      
          when "Generar" then 

            begin 
              puts "reporeeeeeee ..."
              render xlsx: 'rpt_cadmin_04'

            end

          else render action: "index"
        end



  end

  private
  def supplierpayment_params
    params.require(:supplier_payment).permit(:company_id,:location_id,:division_id,:bank_acount_id,
      :document_id,:documento,:supplier_id,:tm,:total,:fecha1,:fecha2,:nrooperacion,:operacion,
      :descrip,:comments,:user_id,:processed,:code,:concept_id )

  end

end
