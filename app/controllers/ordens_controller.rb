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
      
     $lcCli  = @company.name 
     $lcdir1 = @company.address1+@company.address2+@company.city+@company.state

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s    
        
      pdf.image "#{Dir.pwd}/public/images/logo2.png", :width => 270        
      pdf.move_down 6        
      pdf.move_down 4
      pdf.text "Cliente   : " + @orden.customer.name  , :size => 10
      pdf.text "Contrato  : "+ @orden.contrato.code, :size => 10
      pdf.text "Medio     : " + @orden.medio.descrip, :size => 10
      pdf.text "Marca     : " +  @orden.marca.descrip, :size => 10
      pdf.text "Version   : " + @orden.version.descrip , :size => 10
      pdf.text "Moneda    : NUEVOS SOLES ", :size => 10
      pdf.text "ORDEN     : #{@orden.code}", :size => 12
      
        
      pdf.move_down 10
      pdf 


  end   

  def build_pdf_body_rpt2(pdf)
    
    pdf.font "Helvetica" , :size => 6

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
    

     for  customerpayment_rpt in @orden_detalle 

        if lcCli == customerpayment_rpt.avisodetail_id 

          $lcCliName = customerpayment_rpt.avisodetail.descrip   
          
          if customerpayment_rpt.dia == '01'
            @total_dia01 += customerpayment_rpt.quantity.round(2)        
          end   
          if customerpayment_rpt.dia == '02' 
            @total_dia02 += customerpayment_rpt.quantity.round(2)        
          end             
          if customerpayment_rpt.dia == '03' 
            @total_dia03 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '04' 
            @total_dia04 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '05' 
            @total_dia05 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '06' 
            @total_dia06 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '07' 
            @total_dia07 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '08' 
            @total_dia08 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '09' 
            @total_dia09 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '10' 
            @total_dia10 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '11' 
            @total_dia11 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '12' 
            @total_dia12 += customerpayment_rpt.quantity.round(2)        
          end 

          if customerpayment_rpt.dia == '13'
            @total_dia13 += customerpayment_rpt.quantity.round(2)        
          end   
          if customerpayment_rpt.dia == '14' 
            @total_dia14 += customerpayment_rpt.quantity.round(2)        
          end             
          if customerpayment_rpt.dia == '15' 
            @total_dia15 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '16' 
            @total_dia16 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '17' 
            @total_dia17 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '18' 
            @total_dia18 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '19' 
            @total_dia19 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '20' 
            @total_dia20 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '21' 
            @total_dia21 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '22' 
            @total_dia22 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '23' 
            @total_dia23 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '24' 
            @total_dia24 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '25' 
            @total_dia25 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '26' 
            @total_dia26 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '27' 
            @total_dia27 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '28' 
            @total_dia28 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '29' 
            @total_dia29 += customerpayment_rpt.quantity.round(2)        
          end           
          if customerpayment_rpt.dia == '30' 
            @total_dia30 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '31' 
            @total_dia31 += customerpayment_rpt.quantity.round(2)        
          end 


        else
          
            @total_cliente = @total_anterior+
            @total_dia01+
            @total_dia02+
            @total_dia03+
            @total_dia04+
            @total_dia05+
            @total_dia06+
            @total_dia07+
            @total_dia08+
            @total_dia09+
            @total_dia10+
            @total_dia11+
            @total_dia12+
            @total_dia13+
            @total_dia14+
            @total_dia15+
            @total_dia16+
            @total_dia17+
            @total_dia18+
            @total_dia19+
            @total_dia20+
            @total_dia21+
            @total_dia22+
            @total_dia23+
            @total_dia24+
            @total_dia25+
            @total_dia26+
            @total_dia27+
            @total_dia28+
            @total_dia29+
            @total_dia30+
            @total_dia31
            
            row = []
            row << nroitem.to_s        
            row << $lcCliName
            row << sprintf("%.2f",@total_anterior.to_s)
            row << sprintf("%.2f",@total_dia01.to_s)
            row << sprintf("%.2f",@total_dia02.to_s)
            row << sprintf("%.2f",@total_dia03.to_s)
            row << sprintf("%.2f",@total_dia04.to_s)
            row << sprintf("%.2f",@total_dia05.to_s)
            row << sprintf("%.2f",@total_dia06.to_s)
            row << sprintf("%.2f",@total_dia07.to_s)
            row << sprintf("%.2f",@total_dia08.to_s)
            row << sprintf("%.2f",@total_dia09.to_s)
            row << sprintf("%.2f",@total_dia10.to_s)
            row << sprintf("%.2f",@total_dia11.to_s)
            row << sprintf("%.2f",@total_dia12.to_s)
            row << sprintf("%.2f",@total_dia13.to_s)
            row << sprintf("%.2f",@total_dia14.to_s)
            row << sprintf("%.2f",@total_dia15.to_s)
            row << sprintf("%.2f",@total_dia16.to_s)
            row << sprintf("%.2f",@total_dia17.to_s)
            row << sprintf("%.2f",@total_dia18.to_s)
            row << sprintf("%.2f",@total_dia19.to_s)
            row << sprintf("%.2f",@total_dia20.to_s)
            row << sprintf("%.2f",@total_dia21.to_s)
            row << sprintf("%.2f",@total_dia22.to_s)
            row << sprintf("%.2f",@total_dia23.to_s)
            row << sprintf("%.2f",@total_dia24.to_s)
            row << sprintf("%.2f",@total_dia25.to_s)
            row << sprintf("%.2f",@total_dia26.to_s)
            row << sprintf("%.2f",@total_dia27.to_s)
            row << sprintf("%.2f",@total_dia28.to_s)
            row << sprintf("%.2f",@total_dia29.to_s)
            row << sprintf("%.2f",@total_dia30.to_s)
            row << sprintf("%.2f",@total_dia31.to_s)
            
            
            row << sprintf("%.2f",@total_cliente.to_s)

            table_content << row            
            ## TOTAL XMES GENERAL
            @total_anterior_column +=  @total_anterior

            @total_dia01_column += @total_dia01
            @total_dia02_column += @total_dia02
            @total_dia03_column += @total_dia03
            @total_dia04_column += @total_dia04
            @total_dia05_column += @total_dia05
            @total_dia06_column += @total_dia06
            @total_dia07_column += @total_dia07
            @total_dia08_column += @total_dia08
            @total_dia09_column += @total_dia09
            @total_dia10_column += @total_dia10
            @total_dia11_column += @total_dia11
            @total_dia12_column += @total_dia12
            @total_dia13_column += @total_dia13
            @total_dia14_column += @total_dia14
            @total_dia15_column += @total_dia15
            @total_dia16_column += @total_dia16
            @total_dia17_column += @total_dia17
            @total_dia18_column += @total_dia18
            @total_dia19_column += @total_dia19
            @total_dia20_column += @total_dia20
            @total_dia21_column += @total_dia21
            @total_dia22_column += @total_dia22
            @total_dia23_column += @total_dia23
            @total_dia24_column += @total_dia24
            @total_dia25_column += @total_dia25
            @total_dia26_column += @total_dia26
            @total_dia27_column += @total_dia27
            @total_dia28_column += @total_dia28
            @total_dia29_column += @total_dia29
            @total_dia30_column += @total_dia30
            @total_dia31_column += @total_dia31

            @total_cliente = 0 
            ## TOTAL XMES GENERAL

            $lcCliName =customerpayment_rpt.avisodetail.descrip
            lcCli = customerpayment_rpt.avisodetail_id


            @total_anterior = 0
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

            @total_cliente = 0 


if customerpayment_rpt.dia == '01'
            @total_dia01 += customerpayment_rpt.quantity.round(2)        
          end   
          if customerpayment_rpt.dia == '02' 
            @total_dia02 += customerpayment_rpt.quantity.round(2)        
          end             
          if customerpayment_rpt.dia == '03' 
            @total_dia03 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '04' 
            @total_dia04 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '05' 
            @total_dia05 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '06' 
            @total_dia06 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '07' 
            @total_dia07 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '08' 
            @total_dia08 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '09' 
            @total_dia09 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '10' 
            @total_dia10 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '11' 
            @total_dia11 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '12' 
            @total_dia12 += customerpayment_rpt.quantity.round(2)        
          end 

          if customerpayment_rpt.dia == '13'
            @total_dia13 += customerpayment_rpt.quantity.round(2)        
          end   
          if customerpayment_rpt.dia == '14' 
            @total_dia14 += customerpayment_rpt.quantity.round(2)        
          end             
          if customerpayment_rpt.dia == '15' 
            @total_dia15 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '16' 
            @total_dia16 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '17' 
            @total_dia17 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '18' 
            @total_dia18 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '19' 
            @total_dia19 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '20' 
            @total_dia20 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '21' 
            @total_dia21 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '22' 
            @total_dia22 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '23' 
            @total_dia23 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '24' 
            @total_dia24 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '25' 
            @total_dia25 += customerpayment_rpt.quantity.round(2)        
          end
          if customerpayment_rpt.dia == '26' 
            @total_dia26 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '27' 
            @total_dia27 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '28' 
            @total_dia28 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '29' 
            @total_dia29 += customerpayment_rpt.quantity.round(2)        
          end           
          if customerpayment_rpt.dia == '30' 
            @total_dia30 += customerpayment_rpt.quantity.round(2)        
          end 
          if customerpayment_rpt.dia == '31' 
            @total_dia31 += customerpayment_rpt.quantity.round(2)        
          end 

          nroitem = nroitem + 1 



        end 

         @total_general = @total_general + customerpayment_rpt.quantity.round(2)

       end   

      #fin for
          #ultimo cliente 

          @total_cliente = @total_anterior+
            @total_dia01+
            @total_dia02+
            @total_dia03+
            @total_dia04+
            @total_dia05+
            @total_dia06+
            @total_dia07+
            @total_dia08+
            @total_dia09+
            @total_dia10+
            @total_dia11+
            @total_dia12+
            @total_dia13+
            @total_dia14+
            @total_dia15+
            @total_dia16+
            @total_dia17+
            @total_dia18+
            @total_dia19+
            @total_dia20+
            @total_dia21+
            @total_dia22+
            @total_dia23+
            @total_dia24+
            @total_dia25+
            @total_dia26+
            @total_dia27+
            @total_dia28+
            @total_dia29+
            @total_dia30+
            @total_dia31

          @total_anterior_column +=  @total_anterior

            @total_dia01_column += @total_dia01
            @total_dia02_column += @total_dia02
            @total_dia03_column += @total_dia03
            @total_dia04_column += @total_dia04
            @total_dia05_column += @total_dia05
            @total_dia06_column += @total_dia06
            @total_dia07_column += @total_dia07
            @total_dia08_column += @total_dia08
            @total_dia09_column += @total_dia09
            @total_dia10_column += @total_dia10
            @total_dia11_column += @total_dia11
            @total_dia12_column += @total_dia12
            @total_dia13_column += @total_dia13
            @total_dia14_column += @total_dia14
            @total_dia15_column += @total_dia15
            @total_dia16_column += @total_dia16
            @total_dia17_column += @total_dia17
            @total_dia18_column += @total_dia18
            @total_dia19_column += @total_dia19
            @total_dia20_column += @total_dia20
            @total_dia21_column += @total_dia21
            @total_dia22_column += @total_dia22
            @total_dia23_column += @total_dia23
            @total_dia24_column += @total_dia24
            @total_dia25_column += @total_dia25
            @total_dia26_column += @total_dia26
            @total_dia27_column += @total_dia27
            @total_dia28_column += @total_dia28
            @total_dia29_column += @total_dia29
            @total_dia30_column += @total_dia30
            @total_dia31_column += @total_dia31

          
            row = []
            row << nroitem.to_s        
            row << customerpayment_rpt.avisodetail.descrip           
            row << sprintf("%.1f",@total_dia01.to_s)
            row << sprintf("%.1f",@total_dia02.to_s)
            row << sprintf("%.1f",@total_dia03.to_s)
            row << sprintf("%.1f",@total_dia04.to_s)
            row << sprintf("%.1f",@total_dia05.to_s)
            row << sprintf("%.1f",@total_dia06.to_s)
            row << sprintf("%.1f",@total_dia07.to_s)
            row << sprintf("%.1f",@total_dia08.to_s)
            row << sprintf("%.1f",@total_dia09.to_s)
            row << sprintf("%.1f",@total_dia10.to_s)
            row << sprintf("%.1f",@total_dia11.to_s)
            row << sprintf("%.1f",@total_dia12.to_s)
            row << sprintf("%.1f",@total_dia13.to_s)
            row << sprintf("%.1f",@total_dia14.to_s)
            row << sprintf("%.1f",@total_dia15.to_s)
            row << sprintf("%.1f",@total_dia16.to_s)
            row << sprintf("%.1f",@total_dia17.to_s)
            row << sprintf("%.1f",@total_dia18.to_s)
            row << sprintf("%.1f",@total_dia19.to_s)
            row << sprintf("%.1f",@total_dia20.to_s)
            row << sprintf("%.1f",@total_dia21.to_s)
            row << sprintf("%.1f",@total_dia22.to_s)
            row << sprintf("%.1f",@total_dia23.to_s)
            row << sprintf("%.1f",@total_dia24.to_s)
            row << sprintf("%.1f",@total_dia25.to_s)
            row << sprintf("%.1f",@total_dia26.to_s)
            row << sprintf("%.1f",@total_dia27.to_s)
            row << sprintf("%.1f",@total_dia28.to_s)
            row << sprintf("%.1f",@total_dia29.to_s)
            row << sprintf("%.1f",@total_dia30.to_s)
            row << sprintf("%.1f",@total_dia31.to_s)
            row << sprintf("%.2f",@total_cliente.to_s)

             @total_linea = @total_cliente * customerpayment_rpt.tarifa
            row << sprintf("%.2f",customerpayment_rpt.tarifa.to_s)
            row << sprintf("%.2f",@total_linea.to_s)
            @total_linea_general += @total_linea

            table_content << row            
            


        row = []
         row << ""       
         row << " TOTAL GENERAL => "         
         row << sprintf("%.1f",@total_dia01_column.to_s)
         row << sprintf("%.1f",@total_dia02_column.to_s)
         row << sprintf("%.1f",@total_dia03_column.to_s)
         row << sprintf("%.1f",@total_dia04_column.to_s)
         row << sprintf("%.1f",@total_dia05_column.to_s)
         row << sprintf("%.1f",@total_dia06_column.to_s)
         row << sprintf("%.1f",@total_dia07_column.to_s)
         row << sprintf("%.1f",@total_dia08_column.to_s)
         row << sprintf("%.1f",@total_dia09_column.to_s)
         row << sprintf("%.1f",@total_dia10_column.to_s)
         row << sprintf("%.1f",@total_dia11_column.to_s)
         row << sprintf("%.1f",@total_dia12_column.to_s)
         row << sprintf("%.1f",@total_dia13_column.to_s)
         row << sprintf("%.1f",@total_dia14_column.to_s)
         row << sprintf("%.1f",@total_dia15_column.to_s)
         row << sprintf("%.1f",@total_dia16_column.to_s)
         row << sprintf("%.1f",@total_dia17_column.to_s)
         row << sprintf("%.1f",@total_dia18_column.to_s)
         row << sprintf("%.1f",@total_dia19_column.to_s)
         row << sprintf("%.1f",@total_dia20_column.to_s)
         row << sprintf("%.1f",@total_dia21_column.to_s)
         row << sprintf("%.1f",@total_dia22_column.to_s)
         row << sprintf("%.1f",@total_dia23_column.to_s)
         row << sprintf("%.1f",@total_dia24_column.to_s)
         row << sprintf("%.1f",@total_dia25_column.to_s)
         row << sprintf("%.1f",@total_dia26_column.to_s)
         row << sprintf("%.1f",@total_dia27_column.to_s)
         row << sprintf("%.1f",@total_dia28_column.to_s)
         row << sprintf("%.1f",@total_dia29_column.to_s)
         row << sprintf("%.1f",@total_dia30_column.to_s)
         row << sprintf("%.1f",@total_dia31_column.to_s)

         row << sprintf("%.2f",@total_general.to_s)
         row << " "
         row << sprintf("%.2f",@total_linea_general.to_s)
    table_content << row            

        @tax =  @total_linea_general* 0.18
         @importe = @total_linea_general + @tax 

         row = []
         row << ""       
         row << ""         
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " " 
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << ""
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << "IGV. "         
         row << sprintf("%.2f",@tax.to_s)
             table_content << row            
         row = []
         row << ""       
         row << ""         
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " " 
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << ""
         row << " "
         row << " "
         row << " "
         row << " "
         row << " "
         row << "TOTAL"         
         row << sprintf("%.2f",@importe.to_s)

         
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
      pdf.text  "Nota : " + @orden.description


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

        fecha_dd   = parts[1]        
        fecha_mm   = parts[2]        
        fecha_aa   = parts[3]        
        quantity   = parts[4]
        tarifa     = parts[5]
        
        
        product = Avisodetail.find(id.to_i)
        product[:i] = i

        fecha_d = fecha_aa <<"-"<< fecha_mm <<"-"<<fecha_dd <<" 00:00:00" 

        product[:fecha] = fecha_d
        product[:quantity] = quantity.to_f
        product[:tarifa] = tarifa.to_f

        product[:price]  = (product[:tarifa] / 30) * 10      
        
        total = product[:price] * product[:quantity]
             
        product[:total] = total
        puts "fecha : "
        puts product[:fecha]
        @products.push(product)
      end
      
      i += 1
   end
    
    render :layout => false
  end
  
  
  # Autocomplete for products
  def ac_programs
    @products = Avisodetail.where(["(descrip LIKE ?)", "%" +params[:q] + "%"])
   
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
    @customers = Customer.where(["company_id = ? AND (ruc  LIKE ? OR name LIKE ?)", params[:company_id], "%" + params[:q] + "%", "%" + params[:q] + "%"])
   
    render :layout => false
  end
  
  # Show ordens for a company
  def list_invoices
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
    
  end

  # GET /ordens/new
  # GET /ordens/new.xml

  
  
  def new
    @pagetitle = "New orden"
    @action_txt = "Create"

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
    
    @orden = orden.find(params[:id])
    @company = @orden.company
    
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
      if @orden.update_attributes(params[:orden])
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
    @orden = orden.find(params[:id])
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


  def client_data_headers_rpt
      client_headers  = [["Empresa  :", $lcCli ]]
      client_headers << ["Direccion :", $lcdir1]
      client_headers
  end

  def orden_headers_rpt            
      orden_headers  = [["Fecha : ",$lcHora]]    
      orden_headers
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden
      @orden = Orden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_params

    params.require(:orden).permit(:contrato_id,:fecha,:medio_id,:marca_id,:version_id,:fecha1,:fecha2,:tiempo,  
    :code,:company_id,:subtotal,:tax,:total,:user_id,:processed,:customer_id,:description)
  
    end

  

end
