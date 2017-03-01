class OrdensController < ApplicationController
  before_action :set_orden, only: [:show, :edit, :update, :destroy]

  # GET /ordens
  # GET /ordens.json
  def index
    @ordens = Orden.all
  end

  # GET /ordens/1
  # GET /ordens/1.json
  def show
    @orden = Orden.find(params[:id])
    @contratos =Contrato.all
    @medios = Medio.all
    @marcas = Marca.all 
    @versions = Version.all
    @edit = false 


  end

  # GET /ordens/new
  def new
    @orden = Orden.new
    @contratos =Contrato.all
    @medios = Medio.all
    @marcas = Marca.all 
    @versions = Version.all
    @edit = false 
    

  end

  # GET /ordens/1/edit
  def edit
    @orden = Orden.find(params[:id])
    @contratos =Contrato.all
    @medios = Medio.all
    @marcas = Marca.all 
    @versions = Version.all

    @edit = true
  end

  # POST /ordens
  # POST /ordens.json
  def create
    @orden = Orden.new(orden_params)
    @contratos =Contrato.all
    @medios = Medio.all
    @marcas = Marca.all 
    @versions = Version.all

    respond_to do |format|
      if @orden.save
        format.html { redirect_to @orden, notice: 'Orden was successfully created.' }
        format.json { render :show, status: :created, location: @orden }
      else
        format.html { render :new }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ordens/1
  # PATCH/PUT /ordens/1.json
  def update
    respond_to do |format|
      if @orden.update(orden_params)
        format.html { redirect_to @orden, notice: 'Orden was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden }
      else
        format.html { render :edit }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ordens/1
  # DELETE /ordens/1.json
  def destroy
    @orden.destroy
    respond_to do |format|
      format.html { redirect_to ordens_url, notice: 'Orden was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  # reporte completo
  def build_pdf_header_rpt5(pdf)
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


  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def invoice_headers_rpt            
      invoice_headers  = [["Fecha : ",$lcHora]]    
      invoice_headers
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden
      @orden = Orden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_params
      params.require(:orden).permit(:contrato_id, :fecha, :medio_id, :marca_id, :version_id, :fecha1, :fecha2, :tiempo,:code)
    end
end
