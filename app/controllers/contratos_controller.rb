class ContratosController < ApplicationController
  before_action :set_contrato, only: [:show, :edit, :update, :destroy]


  # GET /contratos
  # GET /contratos.json
  def index
    @contratos = Contrato.all
  end

  # GET /contratos/1
  # GET /contratos/1.json
  def show
    @contrato= Contrato.find(params[:id])
    @contrato_details = @contrato.contrato_details 
    
     respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contrato }
    end
  end

  # GET /contratos/new
  def new
    @contrato = Contrato.new
    @customers = Customer.all 

    @medios =Medio.all 
    @contrato[:code] = "#{generate_guid11()}"
    @contrato[:nrocuotas]=0
    @contrato[:comision1]=0.00
    @contrato[:comision2]=0.00
    @contrato[:comision3]=0.00
    @contrato[:importe]=0.00
  end

  # GET /contratos/1/edit
  def edit

      @contrato = Contrato.find(params[:id])
      
      #@contrato[:importe] = @contrato.importe 
      @edit = true
            
      @customers = Customer.all 
      @medios =Medio.all 
        
  end

  # POST /contratos
  # POST /contratos.json
  def create
    @contrato = Contrato.new(contrato_params)
    @customers = Customer.all 
    @medios =  Medio.all 
    
    
    respond_to do |format|
      if @contrato.save
         @contrato.correlativo 

        format.html { redirect_to @contrato, notice: 'Contrato was successfully created.' }
        format.json { render :show, status: :created, location: @contrato }
      else
        format.html { render :new }
        format.json { render json: @contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contratos/1
  # PATCH/PUT /contratos/1.json
  def update
    respond_to do |format|
      if @contrato.update(contrato_params)
        format.html { redirect_to @contrato, notice: 'Contrato was successfully updated.' }
        format.json { render :show, status: :ok, location: @contrato }
      else
        format.html { render :edit }
        format.json { render json: @contrato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contratos/1
  # DELETE /contratos/1.json
  def destroy
    @contrato.destroy
    respond_to do |format|
      format.html { redirect_to contratos_url, notice: 'Contrato was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # reporte completo
  
  def build_pdf_header_rpt5(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  = @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city

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

  def build_pdf_body_rpt5(pdf)
    
    pdf.text "Listado de Contratos desde "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 
  
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Contrato::TABLE_HEADERS.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      nroitem=1

      @totales = 0
      @cantidad = 0
      nroitem = 1

       for  product in @contratos_rpt
 
            row = []         
            row << nroitem.to_s
            row << product.code
            row << product.fecha.strftime("%d/%m/%Y")
            row << product.customer.name 
            row << product.medio.descrip
            row << product.get_moneda
            row << product.get_contrato
            row << sprintf("%.2f",product.nrocuotas.to_s)
            row << sprintf("%.2f",product.comision1.to_s)
            row << sprintf("%.2f",product.comision2.to_s)
            row << sprintf("%.2f",product.importe.to_s)
          
            table_content << row

            @totales += product.importe 
            

            nroitem=nroitem + 1
       
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
      row << " "
      row << " "
      row << sprintf("%.2f",@totales.to_s)


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

  def rpt_contratos1
  
    @company=Company.find(params[:company_id])          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
    @contratos_rpt = @company.get_contratos_day(@fecha1,@fecha2)

    Prawn::Document.generate("app/pdf_output/rpt_contrato1.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt5(pdf)
        pdf = build_pdf_body_rpt5(pdf)
        build_pdf_footer_rpt5(pdf)
        $lcFileName =  "app/pdf_output/rpt_contrato1.pdf"              
    end     
    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_contrato1.pdf", :type => 'application/pdf', :disposition => 'inline')

  end


#fin reporte de ingresos x producto 

# inicio de reporte 

# reporte completo
  def build_pdf_header_rpt6(pdf)
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

  def build_pdf_body_rpt6(pdf)
    
    pdf.text "Listado de Contratos desde "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 
  
    pdf.font "Helvetica" , :size => 6

      headers = []
      table_content = []

      Contrato::TABLE_HEADERS.each do |header|
        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end

      table_content << headers

      
      nroitem=1

      @totales = 0
      @cantidad = 0
      nroitem = 1

       for  product in @contratos_rpt
            @contrato= Contrato.find(product.id)
            @contrato_details = @contrato.contrato_details 
      
            row = []         
            row << nroitem.to_s
            row << product.code
            row << product.fecha.strftime("%d/%m/%Y")
            row << product.customer.name 
            row << product.medio.descrip
            row << product.get_moneda
            row << product.get_contrato
            row << sprintf("%.2f",product.nrocuotas.to_s)
            row << sprintf("%.2f",product.comision1.to_s)
            row << sprintf("%.2f",product.comision2.to_s)
            row << sprintf("%.2f",product.importe.to_s)
          
            table_content << row
            
            
              
            for detalle in   @contrato_details 
              row = []          
              row << detalle.nro
              row << " "
              row << detalle.fecha.strftime("%d/%m/%Y")
              if detalle.importe.to_s != ""
              row << sprintf("%.2f",detalle.importe.to_s)
              else
                
              end 
              
              if detalle.vventa.to_s != ""
              row << sprintf("%.2f",detalle.vventa.to_s)
              else
              row << ""
              end 
              
              if detalle.comision1.to_s != ""
              row << sprintf("%.2f",detalle.comision1.to_s)
            else
              row << ""
            end 
              if detalle.comision2.to_s != ""
              row << sprintf("%.2f",detalle.comision2.to_s)
            else
              row << ""
            end 
            if detalle.comision2.to_s != ""
              row << sprintf("%.2f",detalle.total.to_s)
            else
              row << ""
            end 
              
              row << detalle.facturacanal
              if detalle.fecha2 != nil
               row << detalle.fecha2.strftime("%d/%m/%Y") 
              else
               row << " "
              end 
              row << detalle.factura1 
              row << detalle.factura2
              
              table_content << row
            end 
        

            @totales += product.importe 
            

            nroitem=nroitem + 1
       
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
      row << " "
      row << " "
      row << sprintf("%.2f",@totales.to_s)


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

    def build_pdf_footer_rpt6(pdf)            
      pdf.text "" 
      pdf.bounding_box([0, 30], :width => 535, :height => 40) do
      pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]
      end

      pdf
      
  end

  def rpt_contratos2
  
    @company=Company.find(params[:company_id])          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]    
    @contratos_rpt = @company.get_contratos_day(@fecha1,@fecha2)

    Prawn::Document.generate("app/pdf_output/rpt_contrato2.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt6(pdf)
        pdf = build_pdf_body_rpt6(pdf)
        build_pdf_footer_rpt6(pdf)
        $lcFileName =  "app/pdf_output/rpt_contrato2.pdf"              
    end     
    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_contrato2.pdf", :type => 'application/pdf', :disposition => 'inline')

  end


# reporte completo EECC


  def build_pdf_header_rpt3(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.strftime('%H:%M').to_s

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

  def build_pdf_body_rpt3(pdf)
    
    pdf.text "Contratos : "+@fecha1.to_s+ " Hasta: "+@fecha2.to_s , :size => 8 
  
    pdf.font "Helvetica" , :size => 6

      headers = []
      headers2 = []
      table_content = []
      
      nroitem=1

      @totales = 0
      @cantidad = 0
      nroitem = 1

      data = [ ["Cuota ", "Valor", "I.G.V.","Total","Factura","Factura","Fecha",""],
      ["Nro. Vcmto ", "Venta", "","Cuota","Canal","Masa","Cancela.","Sit."]]
      
      pdf.table data, :cell_style => { :font => "Times-Roman", :font_style => :bold ,:size=>11},:width=> 540
      pdf.move_down 10
      
        
       lcCanal = @contratos_rpt.first.medio_id
       lcCliente = @contratos_rpt.first.customer_id
       
       a = @contratos_rpt.first
       
            row = []
            row <<  "CANAL  :"
            row <<  a.medio.code
            row <<  a.moneda.sigla 
            table_content << row
            
            
            row = []
            row <<  "CLIENTE :"
            row <<  a.customer.ruc 
            row <<  a.customer.descrip 
            table_content << row
            
       for  product in @contratos_rpt
           
            @contrato= Contrato.find(product.id)
            @orden_details = Orden.where(contrato_id: @contrato.id)
            @importe = product.importe
              
        if lcCanal == product.medio_id
          if lcCliente == product.customer_id
            row = []
            row << ""
            row << product.nrocuotas
            row << product.fecha.strftime("%d/%m/%Y") 
            row << product.vventa
            row << ""
            row << product.importe 
            row << product.facturacanal 
            row << product.fecha2.strftime("%d/%m/%Y")  
            row << product.sit 
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row

            nroitem=nroitem + 1
          else
            totals = []            
            total_cliente_doc_payable   = 0
            total_cliente_doc_tax   = 0
            total_cliente_doc_total   = 0
            
            #total_cliente_doc_payable = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
            #otal_cliente_doc_tax     = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
            #total_cliente_doc_total   = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << ""
            row << "TOTALES POR CLIENTE  => "            
            row << ""
            
            table_content << row
            
            lcDocumento = product.document_id
            
            row = []
            row << ""
            row << "CLIENTE :"
            row << product.customer.name  
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row
            
            row << ""
            row << product.nrocuotas
            row << product.fecha.strftime("%d/%m/%Y") 
            row << product.vventa
            row << ""
            row << product.importe 
            row << product.facturacanal 
            row << product.fecha2.strftime("%d/%m/%Y")  
            row << product.sit 
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row

            nroitem=nroitem + 1
            
          end 
            
        else
            total_cliente_doc_payable   = 0
            total_cliente_doc_tax   = 0
            total_cliente_doc_total   = 0
            
        #    total_cliente_doc_payable = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
        #    total_cliente_doc_tax     = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
        #    total_cliente_doc_total   = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << ""
            row << "TOTALES POR CLIENTE => "            
            row << ""
            
            table_content << row
          
          
            totals = []            
            total_cliente_moneda_payable   = 0
            total_cliente_moneda_tax   = 0
            total_cliente_moneda_total   = 0
            
            #total_cliente_moneda_payable = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"payable_amount")
            #total_cliente_moneda_tax     = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"tax_amount")
            #total_cliente_moneda_total   = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << ""
            row << "TOTALES POR MEDIO  => "            
            row << ""
            
            table_content << row
            
            row = []
            row << ""
            row << "MEDIO  :"
            row << product.medio.descrip
            row << product.medio.sigla 
            row << ""
            row << ""
            row << ""
            row << ""
            table_content << row
            
          
            row = []
            row << ""
            row << "CLIENTE  :"
            row << a.customer.name 
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            
            table_content << row
            

            row << ""
            row << product.nrocuotas
            row << product.fecha.strftime("%d/%m/%Y") 
            row << product.vventa
            row << ""
            row << product.importe 
            row << product.facturacanal 
            row << product.fecha2.strftime("%d/%m/%Y")  
            row << product.sit 
            row <<  sprintf("%.2f",product.payable_amount.to_s)
            row <<  sprintf("%.2f",product.tax_amount.to_s)
            row <<  sprintf("%.2f",product.total_amount.to_s)
            table_content << row

            lcMoneda = product.moneda_id
            nroitem=nroitem + 1
            
        end 
        
        end
        
          total_cliente_doc_payable   = 0
            total_cliente_doc_tax   = 0
            total_cliente_doc_total   = 0
            
          #  total_cliente_doc_payable = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"payable_amount")
           # total_cliente_doc_tax     = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"tax_amount")
          #  total_cliente_doc_total   = @company.get_purchases_by_doc_value(@fecha1,@fecha2, lcMoneda,lcDocumento,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << ""
            row << "TOTALES POR CLIENTE  => "            
            row << ""
            
            table_content << row
          

           lcMedio = @purchases_all_rpt.last.medio_id
            
            total_cliente_moneda_payable   = 0
            total_cliente_moneda_tax   = 0
            total_cliente_moneda_total   = 0
            
            #total_cliente_moneda_payable = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"payable_amount")
            #total_cliente_moneda_tax     = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"tax_amount")
            #total_cliente_moneda_total   = @company.get_purchases_by_day_value(@fecha1,@fecha2, lcMoneda,"total_amount")
            
            row =[]
            row << ""
            row << ""
            row << ""
            row << "TOTALES POR MEDIO => "            
            row << ""
            
            table_content << row
      
      
      result = pdf.table table_content, {:position => :center,
                                        :header => false,
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

    def build_pdf_footer_rpt3(pdf)            
      pdf.text "" 
      pdf.bounding_box([0, 30], :width => 535, :height => 40) do
      pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom - 20]
      end

      pdf
      
  end

  def rpt_contratos3
  
    @company=Company.find(params[:company_id])          
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]  
    
    @contratos_rpt = @company.get_contratos_day(@fecha1,@fecha2)

    Prawn::Document.generate("app/pdf_output/rpt_contrato3.pdf") do |pdf|
        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt3(pdf)
        pdf = build_pdf_body_rpt3(pdf)
        build_pdf_footer_rpt3(pdf)
        $lcFileName =  "app/pdf_output/rpt_contrato3.pdf"              
    end     
    $lcFileName1=File.expand_path('../../../', __FILE__)+ "/"+$lcFileName              
    send_file("app/pdf_output/rpt_contrato3.pdf", :type => 'application/pdf', :disposition => 'inline')

  end




  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def invoice_headers_rpt            
      invoice_headers  = [["Fecha : ",$lcFecha1]]    
      invoice_headers << ["Hora :", $lcHora]
      invoice_headers
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contrato
      @contrato = Contrato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contrato_params
      params.require(:contrato).permit(:code, :fecha, :customer_id, :medio_id, :importe, :moneda_id, :tipocontrato_id, :nrocuotas, :comision1, :comision2,:description,:codigointerno,:comision3)
    end
end
