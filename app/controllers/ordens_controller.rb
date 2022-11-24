include UsersHelper
include CustomersHelper
include AvisodetailsHelper

class OrdensController < ApplicationController
  before_filter :authenticate_user!,:checkProducts


  def do_cerrar
    @orden = Orden.find(params[:id])
    @orden[:processed] = "3"

    @orden.cerrar 

    flash[:notice] = "Documento a sido cerrado."
    redirect_to @orden
  end

  def do_cerrar_orden
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]
    @company = Company.find(1)

    @orden = Orden.where(["fecha1>= ? AND fecha1 <= ? ", "#{@fecha1} 00:00:00", "#{@fecha2} 23:59:59"]).update_all(processed:"3", date_processed: Time.now)  
    

  
    flash[:notice] = "Documentos ha sido cerrados"

    

  end



  def do_anular
    @orden = Orden.find(params[:id])
    @orden[:processed] = "2"

    @orden.anular

    flash[:notice] = "Documento a sido anulado."
    redirect_to @orden
  end


##-------------------------------------------------------------------------------------
## REPORTE DE ESTADISTICA DE VENTAS
##-------------------------------------------------------------------------------------

  def build_pdf_header_rpt2(pdf)
     pdf.font "Helvetica" , :size => 8

     $lcCli  =  @orden.customer.name
     $lcRucCli =  @orden.customer.ruc
     $lcDirCli = ""

     $lcFecha1= Date.today.strftime("%d/%m/%Y").to_s
     $lcHora  = Time.now.to_s

      pdf.image "#{Dir.pwd}/public/images/logomas.jpg", :width => 130


      pdf.move_down 20

      pdf.text "   Lima, " << @orden.fecha.strftime("%d/%m/%Y") ,:size =>10 ,:style=> :bold

      #pdf.text supplier.street, :size => 10
      #pdf.text supplier.district, :size => 10
      #pdf.text supplier.city, :size => 1

    max_rows = [client_data_headers_1.length, invoice_headers_1.length, invoice_headers_2.length].max
      rows = []
      (1..max_rows).each do |row|
        rows_index = row - 1
        rows[rows_index] = []
        rows[rows_index] += (client_data_headers_1.length >= row ? client_data_headers_1[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers_1.length >= row ? invoice_headers_1[rows_index] : ['',''])
        rows[rows_index] += (invoice_headers_2.length >= row ? invoice_headers_2[rows_index] : ['',''])

      end

      if rows.present?

        pdf.table(rows, {
          :position => :left,
          :cell_style => {:border_width => 0,:height => 17 },
          :width => pdf.bounds.width/3*3

        }) do
          columns([0, 2,4]).font_style = :bold

        end

        pdf.move_down 5

      end
   

     if @orden.processed == "2"


    pdf.bounding_box([250, 540], :width => 200, :height => 70) do
      
        pdf.move_down 15
        pdf.font "Helvetica", :style => :bold do
          pdf.text "**  A N U L A D O ** ", :align => :center,:size => 20
         

        end
      end

    end 


       pdf.bounding_box([550, 540], :width => 170, :height => 70) do
        pdf.stroke_bounds
        pdf.move_down 15
        pdf.font "Helvetica", :style => :bold do
          pdf.text "R.U.C: 20100105609", :align => :center,:size => 10
          pdf.text "ORDEN DE TRANSMISION", :align => :center,:size  =>10
          pdf.text "#{@orden.code}"+" REV."+"#{@orden.revision}", :align => :center,:size  =>10
          pdf.text @month_name, :align => :center,:size  =>10,
                                 :style => :bold

        end
      end

      pdf.move_down 50


    pdf


  end



  def build_pdf_body_rpt10(pdf)



    pdf.font "Helvetica" , :size => 5

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
      #table_content << headers

      nroitem = 1


      # tabla pivoteadas
      # hash of hashes
        # pad columns with spaces and bars from max_lengths

      @total_general = 0
      @total_anterior = 0
      @total_cliente = 0

     
      @total_anterior_column = 0
      @total_linea_general = 0

      @orden_detalle =  @orden.get_orden_products()

      lcCli = @orden_detalle.first.avisodetail_id
      $lcCliName = ""

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)




     row = []

   

      row << "MEDIO"
      row << "MOTIVO "
      row << "DURACION"
      row << "NRO.SALAS"
      row << "NRO.SEMANAS"
      row << "PELICULA"
      row << "TARIFA"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.medio_detail.name[0..14]
            row << @orden.version.descrip 

            row << formatea_number(order.duracion)
            row << formatea_number(order.nro_salas)
            row << formatea_number(order.nro_semanas)
            row << order.pelicula

            row << money(order.tarifa)
            row << money(order.total)           

            table_content << row
             @total_linea_general += order.total 
          
             nroitem = nroitem + 1

       end



     

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left
                                          columns([0]).width = 120

                                          columns([1]).align=:left
                                          columns([1]).width = 120

                                          columns([2]).align=:center
                                          columns([2]).width = 40

                                          columns([3]).align=:center
                                          columns([3]).width = 40
                                          columns([4]).align=:center
                                          columns([4]).width = 50
                                          columns([5]).align=:center

                                          columns([6]).align=:center
                                           columns([6]).width = 50


                                          columns([7]).align=:center
                                           columns([7]).width = 50


          end
      pdf

    end



  def build_pdf_body_rpt2(pdf)



    pdf.font "Helvetica" , :size => 5

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
      #table_content << headers

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

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)


      fechadia1 = anio.to_s << "-" << mes.to_s.rjust(2, '0') << "-" << "01"
      fechadia2 = anio.to_s << "-" << mes.to_s << "-" << "02"
      fechadia3 = anio.to_s << "-" << mes.to_s << "-" << "03"
      fechadia4 = anio.to_s << "-" << mes.to_s << "-" << "04"
      fechadia5 = anio.to_s << "-" << mes.to_s << "-" << "05"
      fechadia6 = anio.to_s << "-" << mes.to_s << "-" << "06"
      fechadia7 = anio.to_s << "-" << mes.to_s << "-" << "07"
      fechadia8 = anio.to_s << "-" << mes.to_s << "-" << "08"
      fechadia9 = anio.to_s << "-" << mes.to_s << "-" << "09"
      fechadia10 = anio.to_s << "-" << mes.to_s << "-" << "10"
      fechadia11 = anio.to_s << "-" << mes.to_s << "-" << "11"
      fechadia12 = anio.to_s << "-" << mes.to_s << "-" << "12"
      fechadia13 = anio.to_s << "-" << mes.to_s << "-" << "13"
      fechadia14 = anio.to_s << "-" << mes.to_s << "-" << "14"
      fechadia15 = anio.to_s << "-" << mes.to_s << "-" << "15"
      fechadia16 = anio.to_s << "-" << mes.to_s << "-" << "16"
      fechadia17 = anio.to_s << "-" << mes.to_s << "-" << "17"
      fechadia18 = anio.to_s << "-" << mes.to_s << "-" << "18"
      fechadia19 = anio.to_s << "-" << mes.to_s << "-" << "19"
      fechadia20 = anio.to_s << "-" << mes.to_s << "-" << "20"
      fechadia21 = anio.to_s << "-" << mes.to_s << "-" << "21"
      fechadia22 = anio.to_s << "-" << mes.to_s << "-" << "22"
      fechadia23 = anio.to_s << "-" << mes.to_s << "-" << "23"
      fechadia24 = anio.to_s << "-" << mes.to_s << "-" << "24"
      fechadia25 = anio.to_s << "-" << mes.to_s << "-" << "25"
      fechadia26 = anio.to_s << "-" << mes.to_s << "-" << "26"
      fechadia27 = anio.to_s << "-" << mes.to_s << "-" << "27"
      if days_mes >=28
        fechadia28 = anio.to_s << "-" << mes.to_s << "-" << "28"
      else
        fechadia28=""
      end
      if days_mes >=29
        fechadia29 = anio.to_s << "-" << mes.to_s << "-" << "29"
      else
        fechadia29=""
      end
      if days_mes >=30
        fechadia30 = anio.to_s << "-" << mes.to_s << "-" << "30"
      else
        fechadia30=""
      end
      if days_mes >=31
        fechadia31 = anio.to_s << "-" << mes.to_s << "-" << "31"
      else
        fechadia31=""
      end


     row = []

      row << "PROGRAMA"
      row << "HORA "
      row << "01"+"\n"+get_name_dia(fechadia1)
      row << "02"+"\n"+get_name_dia(fechadia2)
      row << "03"+"\n"+get_name_dia(fechadia3)
      row << "04"+"\n"+get_name_dia(fechadia4)
      row << "05"+"\n"+get_name_dia(fechadia5)
      row << "06"+"\n"+get_name_dia(fechadia6)
      row << "07"+"\n"+get_name_dia(fechadia7)
      row << "08"+"\n"+get_name_dia(fechadia8)
      row << "09"+"\n"+get_name_dia(fechadia9)
      row << "10"+"\n"+get_name_dia(fechadia10)
      row << "11"+"\n"+get_name_dia(fechadia11)
      row << "12"+"\n"+get_name_dia(fechadia12)
      row << "13"+"\n"+get_name_dia(fechadia13)
      row << "14"+"\n"+get_name_dia(fechadia14)
      row << "15"+"\n"+get_name_dia(fechadia15)
      row << "16"+"\n"+get_name_dia(fechadia16)
      row << "17"+"\n"+get_name_dia(fechadia17)
      row << "18"+"\n"+get_name_dia(fechadia18)
      row << "19"+"\n"+get_name_dia(fechadia19)
      row << "20"+"\n"+get_name_dia(fechadia20)
      row << "21"+"\n"+get_name_dia(fechadia21)
      row << "22"+"\n"+get_name_dia(fechadia22)
      row << "23"+"\n"+get_name_dia(fechadia23)
      row << "24"+"\n"+get_name_dia(fechadia24)
      row << "25"+"\n"+get_name_dia(fechadia25)
      row << "26"+"\n"+get_name_dia(fechadia26)
      row << "27"+"\n"+get_name_dia(fechadia27)
      row << "28"+"\n"+get_name_dia(fechadia28)
      if fechadia29 != ""
        row << "29"+"\n"+get_name_dia(fechadia29)
      end
      if fechadia30 != ""
        row << "30"+"\n"+get_name_dia(fechadia30)
      end
      if fechadia31 != ""
        row << "31"+"\n"+get_name_dia(fechadia31)
      end
      row << "TOTAL"
      row << "R.MILES"
      row << "TARIFA"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.descrip[0..14]
            row << order.h
            row << formatea_number(order.d01)
            row << formatea_number(order.d02)
            row << formatea_number(order.d03)
            row << formatea_number(order.d04)
            row << formatea_number(order.d05)
            row << formatea_number(order.d06)
            row << formatea_number(order.d07)
            row << formatea_number(order.d08)
            row << formatea_number(order.d09)
            row << formatea_number(order.d10)
            row << formatea_number(order.d11)
            row << formatea_number(order.d12)
            row << formatea_number(order.d13)
            row << formatea_number(order.d14)
            row << formatea_number(order.d15)
            row << formatea_number(order.d16)
            row << formatea_number(order.d17)
            row << formatea_number(order.d18)
            row << formatea_number(order.d19)
            row << formatea_number(order.d20)
            row << formatea_number(order.d21)
            row << formatea_number(order.d22)
            row << formatea_number(order.d23)
            row << formatea_number(order.d24)
            row << formatea_number(order.d25)
            row << formatea_number(order.d26)
            row << formatea_number(order.d27)
            row << formatea_number(order.d28)
            if fechadia29 != ""
              row << formatea_number(order.d29)
            end
            if fechadia30 != ""
              row << formatea_number(order.d30)
            end
            if fechadia31 != ""
              row << formatea_number(order.d31)
            end


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
            row << order.rating2

            row << money(order.price)

            row << money(order.total)

            table_content << row
             @total_linea_general += @total_linea
             @total_linea = 0
          nroitem = nroitem + 1

       end



        row = []
         row << "TOTAL =>"
         row << "  "
         row << formatea_number(@total_dia01_column)
         row << formatea_number(@total_dia02_column)
         row << formatea_number(@total_dia03_column)
         row << formatea_number(@total_dia04_column)
         row << formatea_number(@total_dia05_column)
         row << formatea_number(@total_dia06_column)
         row << formatea_number(@total_dia07_column)
         row << formatea_number(@total_dia08_column)
         row << formatea_number(@total_dia09_column)
         row << formatea_number(@total_dia10_column)
         row << formatea_number(@total_dia11_column)
         row << formatea_number(@total_dia12_column)
         row << formatea_number(@total_dia13_column)
         row << formatea_number(@total_dia14_column)
         row << formatea_number(@total_dia15_column)
         row << formatea_number(@total_dia16_column)
         row << formatea_number(@total_dia17_column)
         row << formatea_number(@total_dia18_column)
         row << formatea_number(@total_dia19_column)
         row << formatea_number(@total_dia20_column)
         row << formatea_number(@total_dia21_column)
         row << formatea_number(@total_dia22_column)
         row << formatea_number(@total_dia23_column)
         row << formatea_number(@total_dia24_column)
         row << formatea_number(@total_dia25_column)
         row << formatea_number(@total_dia26_column)
         row << formatea_number(@total_dia27_column)
         row << formatea_number(@total_dia28_column)
          if fechadia29 != ""
             row << formatea_number(@total_dia29_column)
          end
             if fechadia30 != ""
           row << formatea_number(@total_dia30_column)
         end
            if fechadia31 != ""
           row << formatea_number(@total_dia31_column)
         end

           row << sprintf("%.2f",@total_linea_general.to_s)
           row << " "
         row << " "
         row << " "

         table_content << row

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left
                                          columns([0]).width = 60

                                          columns([1]).align=:left
                                          columns([1]).width = 26

                                          columns([2]).align=:center


                                          columns([3]).align=:center

                                          columns([4]).align=:center

                                          columns([5]).align=:center

                                          columns([6]).align=:center


                                          columns([7]).align=:center

                                          columns([8]).align=:center

                                          columns([9]).align=:center

                                          columns([10]).align=:center

                                          columns([11]).align=:center

                                          columns([12]).align=:center

                                          columns([13]).align=:center

                                          columns([14]).align=:center

                                          columns([15]).align=:center

                                          columns([16]).align=:center

                                          columns([17]).align=:center

                                          columns([18]).align=:center

                                          columns([19]).align=:center

                                          columns([20]).align=:center

                                          columns([21]).align=:center

                                          columns([22]).align=:center


                                          columns([23]).align=:center

                                          columns([24]).align=:center

                                          columns([25]).align=:center

                                          columns([26]).align=:center

                                          columns([27]).align=:center

                                          columns([28]).align=:center

                                          columns([29]).align=:center
                                          columns([30]).align=:center


                                          columns([31]).align=:center

                                          columns([32]).align=:right


                                          columns([33]).align=:right

                                          columns([33]).width=34

                                          columns([34]).align=:right
                                          columns([34]).width=34


                                          columns([35]).align=:right
                                          columns([35]).width=38


                                          columns([36]).align=:right
                                          columns([36]).width=38



          end
      pdf

    end


  def build_pdf_body_rpt20(pdf)

    pdf.font "Helvetica" , :size => 4

     pdf.move_down 10
      headers = []
      table_content = []
      total_general = 0
      total_factory = 0


      Orden::TABLE_HEADERS3.each do |header|

        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end
      
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

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)


      fechadia1 = anio.to_s << "-" << mes.to_s.rjust(2, '0') << "-" << "01"
      fechadia2 = anio.to_s << "-" << mes.to_s << "-" << "02"
      fechadia3 = anio.to_s << "-" << mes.to_s << "-" << "03"
      fechadia4 = anio.to_s << "-" << mes.to_s << "-" << "04"
      fechadia5 = anio.to_s << "-" << mes.to_s << "-" << "05"
      fechadia6 = anio.to_s << "-" << mes.to_s << "-" << "06"
      fechadia7 = anio.to_s << "-" << mes.to_s << "-" << "07"
      fechadia8 = anio.to_s << "-" << mes.to_s << "-" << "08"
      fechadia9 = anio.to_s << "-" << mes.to_s << "-" << "09"
      fechadia10 = anio.to_s << "-" << mes.to_s << "-" << "10"
      fechadia11 = anio.to_s << "-" << mes.to_s << "-" << "11"
      fechadia12 = anio.to_s << "-" << mes.to_s << "-" << "12"
      fechadia13 = anio.to_s << "-" << mes.to_s << "-" << "13"
      fechadia14 = anio.to_s << "-" << mes.to_s << "-" << "14"
      fechadia15 = anio.to_s << "-" << mes.to_s << "-" << "15"
      fechadia16 = anio.to_s << "-" << mes.to_s << "-" << "16"
      fechadia17 = anio.to_s << "-" << mes.to_s << "-" << "17"
      fechadia18 = anio.to_s << "-" << mes.to_s << "-" << "18"
      fechadia19 = anio.to_s << "-" << mes.to_s << "-" << "19"
      fechadia20 = anio.to_s << "-" << mes.to_s << "-" << "20"
      fechadia21 = anio.to_s << "-" << mes.to_s << "-" << "21"
      fechadia22 = anio.to_s << "-" << mes.to_s << "-" << "22"
      fechadia23 = anio.to_s << "-" << mes.to_s << "-" << "23"
      fechadia24 = anio.to_s << "-" << mes.to_s << "-" << "24"
      fechadia25 = anio.to_s << "-" << mes.to_s << "-" << "25"
      fechadia26 = anio.to_s << "-" << mes.to_s << "-" << "26"
      fechadia27 = anio.to_s << "-" << mes.to_s << "-" << "27"
      if days_mes >=28
        fechadia28 = anio.to_s << "-" << mes.to_s << "-" << "28"
      else
        fechadia28=""
      end
      if days_mes >=29
        fechadia29 = anio.to_s << "-" << mes.to_s << "-" << "29"
      else
        fechadia29=""
      end
      if days_mes >=30
        fechadia30 = anio.to_s << "-" << mes.to_s << "-" << "30"
      else
        fechadia30=""
      end
      if days_mes >=31
        fechadia31 = anio.to_s << "-" << mes.to_s << "-" << "31"
      else
        fechadia31=""
      end


     row = []

      row << "PRODUCTO"
      row << "MOTIVO "
      row << "PROGRAMA "
      row << "TIPO AVISO"
      row << "TIPO TARIFA"
      row << "COBERTURA "
      row << "HORARIO(Hrs)"
      row << "DURACION"

      row << "01"+"\n"+get_name_dia(fechadia1)
      row << "02"+"\n"+get_name_dia(fechadia2)
      row << "03"+"\n"+get_name_dia(fechadia3)
      row << "04"+"\n"+get_name_dia(fechadia4)
      row << "05"+"\n"+get_name_dia(fechadia5)
      row << "06"+"\n"+get_name_dia(fechadia6)
      row << "07"+"\n"+get_name_dia(fechadia7)
      row << "08"+"\n"+get_name_dia(fechadia8)
      row << "09"+"\n"+get_name_dia(fechadia9)
      row << "10"+"\n"+get_name_dia(fechadia10)
      row << "11"+"\n"+get_name_dia(fechadia11)
      row << "12"+"\n"+get_name_dia(fechadia12)
      row << "13"+"\n"+get_name_dia(fechadia13)
      row << "14"+"\n"+get_name_dia(fechadia14)
      row << "15"+"\n"+get_name_dia(fechadia15)
      row << "16"+"\n"+get_name_dia(fechadia16)
      row << "17"+"\n"+get_name_dia(fechadia17)
      row << "18"+"\n"+get_name_dia(fechadia18)
      row << "19"+"\n"+get_name_dia(fechadia19)
      row << "20"+"\n"+get_name_dia(fechadia20)
      row << "21"+"\n"+get_name_dia(fechadia21)
      row << "22"+"\n"+get_name_dia(fechadia22)
      row << "23"+"\n"+get_name_dia(fechadia23)
      row << "24"+"\n"+get_name_dia(fechadia24)
      row << "25"+"\n"+get_name_dia(fechadia25)
      row << "26"+"\n"+get_name_dia(fechadia26)
      row << "27"+"\n"+get_name_dia(fechadia27)
      row << "28"+"\n"+get_name_dia(fechadia28)
      if fechadia29 != ""
        row << "29"+"\n"+get_name_dia(fechadia29)
      end
      if fechadia30 != ""
        row << "30"+"\n"+get_name_dia(fechadia30)
      end
      if fechadia31 != ""
        row << "31"+"\n"+get_name_dia(fechadia31)
      end
      row << "TOTAL 
        AVISOS"

      row << "COSTO"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.medio_detail.name[0..14]
            row << @orden.version.descrip 
            row << order.descrip
            row << order.tipo_aviso.name
            row << order.tipo_tarifa.name
            row << order.cobertura
            row << order.horario

            row << formatea_number(order.duracion)

            row << formatea_number(order.d01)
            row << formatea_number(order.d02)
            row << formatea_number(order.d03)
            row << formatea_number(order.d04)
            row << formatea_number(order.d05)
            row << formatea_number(order.d06)
            row << formatea_number(order.d07)
            row << formatea_number(order.d08)
            row << formatea_number(order.d09)
            row << formatea_number(order.d10)
            row << formatea_number(order.d11)
            row << formatea_number(order.d12)
            row << formatea_number(order.d13)
            row << formatea_number(order.d14)
            row << formatea_number(order.d15)
            row << formatea_number(order.d16)
            row << formatea_number(order.d17)
            row << formatea_number(order.d18)
            row << formatea_number(order.d19)
            row << formatea_number(order.d20)
            row << formatea_number(order.d21)
            row << formatea_number(order.d22)
            row << formatea_number(order.d23)
            row << formatea_number(order.d24)
            row << formatea_number(order.d25)
            row << formatea_number(order.d26)
            row << formatea_number(order.d27)
            row << formatea_number(order.d28)
            if fechadia29 != ""
              row << formatea_number(order.d29)
            end
            if fechadia30 != ""
              row << formatea_number(order.d30)
            end
            if fechadia31 != ""
              row << formatea_number(order.d31)
            end


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
           
            row << money(order.price)

            row << money(order.total)

            table_content << row
             @total_linea_general += @total_linea
             @total_linea = 0
          nroitem = nroitem + 1

       end



        row = []
         row << "TOTAL =>"
         row << "  "
         row << "  "
         row << "  "
         row << "  "
         row << "  "
         row << "  "
         row << "  "
         row << formatea_number(@total_dia01_column)
         row << formatea_number(@total_dia02_column)
         row << formatea_number(@total_dia03_column)
         row << formatea_number(@total_dia04_column)
         row << formatea_number(@total_dia05_column)
         row << formatea_number(@total_dia06_column)
         row << formatea_number(@total_dia07_column)
         row << formatea_number(@total_dia08_column)
         row << formatea_number(@total_dia09_column)
         row << formatea_number(@total_dia10_column)
         row << formatea_number(@total_dia11_column)
         row << formatea_number(@total_dia12_column)
         row << formatea_number(@total_dia13_column)
         row << formatea_number(@total_dia14_column)
         row << formatea_number(@total_dia15_column)
         row << formatea_number(@total_dia16_column)
         row << formatea_number(@total_dia17_column)
         row << formatea_number(@total_dia18_column)
         row << formatea_number(@total_dia19_column)
         row << formatea_number(@total_dia20_column)
         row << formatea_number(@total_dia21_column)
         row << formatea_number(@total_dia22_column)
         row << formatea_number(@total_dia23_column)
         row << formatea_number(@total_dia24_column)
         row << formatea_number(@total_dia25_column)
         row << formatea_number(@total_dia26_column)
         row << formatea_number(@total_dia27_column)
         row << formatea_number(@total_dia28_column)
          if fechadia29 != ""
             row << formatea_number(@total_dia29_column)
          end
             if fechadia30 != ""
           row << formatea_number(@total_dia30_column)
         end
            if fechadia31 != ""
           row << formatea_number(@total_dia31_column)
         end

           row << sprintf("%.2f",@total_linea_general.to_s)
           row << " "
         row << " "
   

         table_content << row

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left                                        
                                          columns([0]).width = 40 
                                          columns([1]).align =:left
                                          columns([1]).width = 40 

                                          columns([2]).align=:center
                                          columns([2]).width = 30 

                                          columns([3]).align=:center
                                          columns([3]).width = 30

                                          columns([4]).align=:center
                                          columns([4]).width = 30 

                                          columns([5]).align=:center
                                          columns([5]).width = 30
                                          columns([6]).align=:center
                                           columns([6]).width = 30
                                          columns([7]).align=:center
                                        
                                          columns([8]).align=:center

                                          columns([9]).align=:center

                                          columns([10]).align=:center

                                          columns([11]).align=:center

                                          columns([12]).align=:center

                                          columns([13]).align=:center

                                          columns([14]).align=:center

                                          columns([15]).align=:center

                                          columns([16]).align=:center

                                          columns([17]).align=:center

                                          columns([18]).align=:center

                                          columns([19]).align=:center

                                          columns([20]).align=:center

                                          columns([21]).align=:center

                                          columns([22]).align=:center


                                          columns([23]).align=:center

                                          columns([24]).align=:center

                                          columns([25]).align=:center

                                          columns([26]).align=:center

                                          columns([27]).align=:center

                                          columns([28]).align=:center

                                          columns([29]).align=:center
                                          columns([30]).align=:center


                                          columns([31]).align=:center

                                          columns([32]).align=:right


                                          columns([33]).align=:right

                                      

                                          columns([34]).align=:right
                                       


                                          columns([35]).align=:right
                                      

                                          columns([36]).align=:right
                                        
                                          columns([37]).align=:right
                                      

                                          columns([38]).align=:right
                                          columns([38]).width = 30 

                                          columns([39]).align=:right
                                          columns([39]).width = 30 

                                          columns([40]).align=:right
                                          columns([40]).width = 30 
                                                                                     


          end
      pdf

    end



   def  build_pdf_body_rpt30(pdf)

    pdf.font "Helvetica" , :size => 5

     pdf.move_down 10
      headers = []
      table_content = []
      total_general = 0
      total_factory = 0


      Orden::TABLE_HEADERS3.each do |header|

        cell = pdf.make_cell(:content => header)
        cell.background_color = "FFFFCC"
        headers << cell
      end
      
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

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)


      fechadia1 = anio.to_s << "-" << mes.to_s.rjust(2, '0') << "-" << "01"
      fechadia2 = anio.to_s << "-" << mes.to_s << "-" << "02"
      fechadia3 = anio.to_s << "-" << mes.to_s << "-" << "03"
      fechadia4 = anio.to_s << "-" << mes.to_s << "-" << "04"
      fechadia5 = anio.to_s << "-" << mes.to_s << "-" << "05"
      fechadia6 = anio.to_s << "-" << mes.to_s << "-" << "06"
      fechadia7 = anio.to_s << "-" << mes.to_s << "-" << "07"
      fechadia8 = anio.to_s << "-" << mes.to_s << "-" << "08"
      fechadia9 = anio.to_s << "-" << mes.to_s << "-" << "09"
      fechadia10 = anio.to_s << "-" << mes.to_s << "-" << "10"
      fechadia11 = anio.to_s << "-" << mes.to_s << "-" << "11"
      fechadia12 = anio.to_s << "-" << mes.to_s << "-" << "12"
      fechadia13 = anio.to_s << "-" << mes.to_s << "-" << "13"
      fechadia14 = anio.to_s << "-" << mes.to_s << "-" << "14"
      fechadia15 = anio.to_s << "-" << mes.to_s << "-" << "15"
      fechadia16 = anio.to_s << "-" << mes.to_s << "-" << "16"
      fechadia17 = anio.to_s << "-" << mes.to_s << "-" << "17"
      fechadia18 = anio.to_s << "-" << mes.to_s << "-" << "18"
      fechadia19 = anio.to_s << "-" << mes.to_s << "-" << "19"
      fechadia20 = anio.to_s << "-" << mes.to_s << "-" << "20"
      fechadia21 = anio.to_s << "-" << mes.to_s << "-" << "21"
      fechadia22 = anio.to_s << "-" << mes.to_s << "-" << "22"
      fechadia23 = anio.to_s << "-" << mes.to_s << "-" << "23"
      fechadia24 = anio.to_s << "-" << mes.to_s << "-" << "24"
      fechadia25 = anio.to_s << "-" << mes.to_s << "-" << "25"
      fechadia26 = anio.to_s << "-" << mes.to_s << "-" << "26"
      fechadia27 = anio.to_s << "-" << mes.to_s << "-" << "27"
      if days_mes >=28
        fechadia28 = anio.to_s << "-" << mes.to_s << "-" << "28"
      else
        fechadia28=""
      end
      if days_mes >=29
        fechadia29 = anio.to_s << "-" << mes.to_s << "-" << "29"
      else
        fechadia29=""
      end
      if days_mes >=30
        fechadia30 = anio.to_s << "-" << mes.to_s << "-" << "30"
      else
        fechadia30=""
      end
      if days_mes >=31
        fechadia31 = anio.to_s << "-" << mes.to_s << "-" << "31"
      else
        fechadia31=""
      end


     row = []



      row << "PRODUCTO"
      row << "MOTIVO "
      row << "MEDIDAS "
      row << "UBICACION"
      row << "COBERTURA"
      
      row << "01"+"\n"+get_name_dia(fechadia1)
      row << "02"+"\n"+get_name_dia(fechadia2)
      row << "03"+"\n"+get_name_dia(fechadia3)
      row << "04"+"\n"+get_name_dia(fechadia4)
      row << "05"+"\n"+get_name_dia(fechadia5)
      row << "06"+"\n"+get_name_dia(fechadia6)
      row << "07"+"\n"+get_name_dia(fechadia7)
      row << "08"+"\n"+get_name_dia(fechadia8)
      row << "09"+"\n"+get_name_dia(fechadia9)
      row << "10"+"\n"+get_name_dia(fechadia10)
      row << "11"+"\n"+get_name_dia(fechadia11)
      row << "12"+"\n"+get_name_dia(fechadia12)
      row << "13"+"\n"+get_name_dia(fechadia13)
      row << "14"+"\n"+get_name_dia(fechadia14)
      row << "15"+"\n"+get_name_dia(fechadia15)
      row << "16"+"\n"+get_name_dia(fechadia16)
      row << "17"+"\n"+get_name_dia(fechadia17)
      row << "18"+"\n"+get_name_dia(fechadia18)
      row << "19"+"\n"+get_name_dia(fechadia19)
      row << "20"+"\n"+get_name_dia(fechadia20)
      row << "21"+"\n"+get_name_dia(fechadia21)
      row << "22"+"\n"+get_name_dia(fechadia22)
      row << "23"+"\n"+get_name_dia(fechadia23)
      row << "24"+"\n"+get_name_dia(fechadia24)
      row << "25"+"\n"+get_name_dia(fechadia25)
      row << "26"+"\n"+get_name_dia(fechadia26)
      row << "27"+"\n"+get_name_dia(fechadia27)
      row << "28"+"\n"+get_name_dia(fechadia28)
      if fechadia29 != ""
        row << "29"+"\n"+get_name_dia(fechadia29)
      end
      if fechadia30 != ""
        row << "30"+"\n"+get_name_dia(fechadia30)
      end
      if fechadia31 != ""
        row << "31"+"\n"+get_name_dia(fechadia31)
      end
      row << "TOTAL 
        AVISOS"

      row << "COSTO"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.medio_detail.name[0..14]
            row << @orden.version.descrip 
            row << order.medidax
            row << order.ubicacion
            row << order.cobertura
            row << formatea_number(order.d01)
            row << formatea_number(order.d02)
            row << formatea_number(order.d03)
            row << formatea_number(order.d04)
            row << formatea_number(order.d05)
            row << formatea_number(order.d06)
            row << formatea_number(order.d07)
            row << formatea_number(order.d08)
            row << formatea_number(order.d09)
            row << formatea_number(order.d10)
            row << formatea_number(order.d11)
            row << formatea_number(order.d12)
            row << formatea_number(order.d13)
            row << formatea_number(order.d14)
            row << formatea_number(order.d15)
            row << formatea_number(order.d16)
            row << formatea_number(order.d17)
            row << formatea_number(order.d18)
            row << formatea_number(order.d19)
            row << formatea_number(order.d20)
            row << formatea_number(order.d21)
            row << formatea_number(order.d22)
            row << formatea_number(order.d23)
            row << formatea_number(order.d24)
            row << formatea_number(order.d25)
            row << formatea_number(order.d26)
            row << formatea_number(order.d27)
            row << formatea_number(order.d28)
            if fechadia29 != ""
              row << formatea_number(order.d29)
            end
            if fechadia30 != ""
              row << formatea_number(order.d30)
            end
            if fechadia31 != ""
              row << formatea_number(order.d31)
            end


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
           
            row << money(order.price)

            row << money(order.total)

            table_content << row
             @total_linea_general += @total_linea
             @total_linea = 0
            nroitem = nroitem + 1

       end



        row = []
         row << "TOTAL =>"
         row << "  "
         row << "  "
         row << "  "
         row << "  "

         row << formatea_number(@total_dia01_column)
         row << formatea_number(@total_dia02_column)
         row << formatea_number(@total_dia03_column)
         row << formatea_number(@total_dia04_column)
         row << formatea_number(@total_dia05_column)
         row << formatea_number(@total_dia06_column)
         row << formatea_number(@total_dia07_column)
         row << formatea_number(@total_dia08_column)
         row << formatea_number(@total_dia09_column)
         row << formatea_number(@total_dia10_column)
         row << formatea_number(@total_dia11_column)
         row << formatea_number(@total_dia12_column)
         row << formatea_number(@total_dia13_column)
         row << formatea_number(@total_dia14_column)
         row << formatea_number(@total_dia15_column)
         row << formatea_number(@total_dia16_column)
         row << formatea_number(@total_dia17_column)
         row << formatea_number(@total_dia18_column)
         row << formatea_number(@total_dia19_column)
         row << formatea_number(@total_dia20_column)
         row << formatea_number(@total_dia21_column)
         row << formatea_number(@total_dia22_column)
         row << formatea_number(@total_dia23_column)
         row << formatea_number(@total_dia24_column)
         row << formatea_number(@total_dia25_column)
         row << formatea_number(@total_dia26_column)
         row << formatea_number(@total_dia27_column)
         row << formatea_number(@total_dia28_column)
          if fechadia29 != ""
             row << formatea_number(@total_dia29_column)
          end
             if fechadia30 != ""
           row << formatea_number(@total_dia30_column)
         end
            if fechadia31 != ""
           row << formatea_number(@total_dia31_column)
         end

           row << sprintf("%.2f",@total_linea_general.to_s)
           row << " "
           row << " "
   

         table_content << row

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left                                        
                                          columns([0]).width = 50 
                                          columns([1]).align =:left
                                          columns([1]).width = 50 

                                          columns([2]).align=:center
                                          columns([2]).width = 50 

                                          columns([3]).align=:center
                                          columns([3]).width = 30

                                          columns([4]).align=:center
                                          columns([4]).width = 30 

                                          columns([5]).align=:center
                                       
                                          columns([6]).align=:center
                                       
                                          columns([7]).align=:center

                                          columns([8]).align=:center

                                          columns([9]).align=:center

                                          columns([10]).align=:center

                                          columns([11]).align=:center

                                          columns([12]).align=:center

                                          columns([13]).align=:center

                                          columns([14]).align=:center

                                          columns([15]).align=:center

                                          columns([16]).align=:center

                                          columns([17]).align=:center

                                          columns([18]).align=:center

                                          columns([19]).align=:center

                                          columns([20]).align=:center

                                          columns([21]).align=:center

                                          columns([22]).align=:center


                                          columns([23]).align=:center

                                          columns([24]).align=:center

                                          columns([25]).align=:center

                                          columns([26]).align=:center

                                          columns([27]).align=:center

                                          columns([28]).align=:center

                                          columns([29]).align=:center
                                          columns([30]).align=:center


                                          columns([31]).align=:center

                                          columns([32]).align=:right


                                          columns([33]).align=:right

                                      

                                          columns([34]).align=:right
                                       


                                          columns([35]).align=:right
                                      

                                          columns([36]).align=:right
                                         columns([36]).width = 30

                                            columns([37]).align=:right
                                      
                                            columns([37]).width = 30
                                            columns([38]).align=:right
                                            columns([38]).width = 30


                                            




          end
      pdf

    end




   def  build_pdf_body_rpt50(pdf)

    pdf.font "Helvetica" , :size => 5

     pdf.move_down 10
      headers = []
      table_content = []
      total_general = 0
      total_factory = 0

      nroitem = 1


      # tabla pivoteadas
      # hash of hashes
        # pad columns with spaces and bars from max_lengths

      @total_general = 0
      @total_anterior = 0
      @total_cliente = 0



      @total_anterior_column = 0
      @total_linea_general = 0


      @orden_detalle =  @orden.get_orden_products()

      lcCli = @orden_detalle.first.avisodetail_id
      $lcCliName = ""

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)



     row = []



      row << "MEDIO "
      row << "MOTIVO "
      row << "CANTIDAD  "
      row << "UBICACION"
      row << "CIUDAD"
      
      row << "PERIODO "

      row << "DETALLE "

           row << "COSTO"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.medio_detail.name[0..14]
            row << @orden.version.descrip 
            row << order.quantity
            row << order.ubicacion

            row << order.ciudad 

            row << order.periodo 

            row << order.detalle 

            row  << money(order.price)
            row  << money(order.total )



            table_content << row

            
             @total_linea_general = order.total 
            nroitem = nroitem + 1

       end



        row = []
         row << "  "
         row << "TOTAL =>"
         row << "  "
         row << "  "
         row << "  "
         row << "  "

        row << "  "
         row << "  "

           row << sprintf("%.2f",@total_linea_general.to_s)
         
   

         table_content << row

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left                                        
                                        
                                          columns([1]).align =:left
                                        
                                          columns([2]).align=:center
                                        

                                          columns([3]).align=:center
                                       

                                          columns([4]).align=:center
                                         

                                          columns([5]).align=:center
                                       
                                          columns([6]).align=:center
                                       
                                          columns([7]).align=:center
                                          columns([7]).width = 50
                                             
                                       
                                          columns([8]).align=:center            
                                          columns([8]).width = 50

                                            




          end
      pdf

    end


      def build_pdf_body_rpt70(pdf)

    pdf.font "Helvetica" , :size => 4

     pdf.move_down 10
      headers = []
      table_content = []
      total_general = 0
      total_factory = 0

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

      mes = @orden.month
      anio = @orden.year
      days_mes = days_of_month(mes,anio)


      fechadia1 = anio.to_s << "-" << mes.to_s.rjust(2, '0') << "-" << "01"
      fechadia2 = anio.to_s << "-" << mes.to_s << "-" << "02"
      fechadia3 = anio.to_s << "-" << mes.to_s << "-" << "03"
      fechadia4 = anio.to_s << "-" << mes.to_s << "-" << "04"
      fechadia5 = anio.to_s << "-" << mes.to_s << "-" << "05"
      fechadia6 = anio.to_s << "-" << mes.to_s << "-" << "06"
      fechadia7 = anio.to_s << "-" << mes.to_s << "-" << "07"
      fechadia8 = anio.to_s << "-" << mes.to_s << "-" << "08"
      fechadia9 = anio.to_s << "-" << mes.to_s << "-" << "09"
      fechadia10 = anio.to_s << "-" << mes.to_s << "-" << "10"
      fechadia11 = anio.to_s << "-" << mes.to_s << "-" << "11"
      fechadia12 = anio.to_s << "-" << mes.to_s << "-" << "12"
      fechadia13 = anio.to_s << "-" << mes.to_s << "-" << "13"
      fechadia14 = anio.to_s << "-" << mes.to_s << "-" << "14"
      fechadia15 = anio.to_s << "-" << mes.to_s << "-" << "15"
      fechadia16 = anio.to_s << "-" << mes.to_s << "-" << "16"
      fechadia17 = anio.to_s << "-" << mes.to_s << "-" << "17"
      fechadia18 = anio.to_s << "-" << mes.to_s << "-" << "18"
      fechadia19 = anio.to_s << "-" << mes.to_s << "-" << "19"
      fechadia20 = anio.to_s << "-" << mes.to_s << "-" << "20"
      fechadia21 = anio.to_s << "-" << mes.to_s << "-" << "21"
      fechadia22 = anio.to_s << "-" << mes.to_s << "-" << "22"
      fechadia23 = anio.to_s << "-" << mes.to_s << "-" << "23"
      fechadia24 = anio.to_s << "-" << mes.to_s << "-" << "24"
      fechadia25 = anio.to_s << "-" << mes.to_s << "-" << "25"
      fechadia26 = anio.to_s << "-" << mes.to_s << "-" << "26"
      fechadia27 = anio.to_s << "-" << mes.to_s << "-" << "27"
      if days_mes >=28
        fechadia28 = anio.to_s << "-" << mes.to_s << "-" << "28"
      else
        fechadia28=""
      end
      if days_mes >=29
        fechadia29 = anio.to_s << "-" << mes.to_s << "-" << "29"
      else
        fechadia29=""
      end
      if days_mes >=30
        fechadia30 = anio.to_s << "-" << mes.to_s << "-" << "30"
      else
        fechadia30=""
      end
      if days_mes >=31
        fechadia31 = anio.to_s << "-" << mes.to_s << "-" << "31"
      else
        fechadia31=""
      end


     row = []

      row << "WEBSITE"
      row << "PRODUCTO"
      row << "MOTIVO "
      row << "TARIFA CPM"
      row << "IMPRESIONES CLICKS"
      
      row << "01"+"\n"+get_name_dia(fechadia1)
      row << "02"+"\n"+get_name_dia(fechadia2)
      row << "03"+"\n"+get_name_dia(fechadia3)
      row << "04"+"\n"+get_name_dia(fechadia4)
      row << "05"+"\n"+get_name_dia(fechadia5)
      row << "06"+"\n"+get_name_dia(fechadia6)
      row << "07"+"\n"+get_name_dia(fechadia7)
      row << "08"+"\n"+get_name_dia(fechadia8)
      row << "09"+"\n"+get_name_dia(fechadia9)
      row << "10"+"\n"+get_name_dia(fechadia10)
      row << "11"+"\n"+get_name_dia(fechadia11)
      row << "12"+"\n"+get_name_dia(fechadia12)
      row << "13"+"\n"+get_name_dia(fechadia13)
      row << "14"+"\n"+get_name_dia(fechadia14)
      row << "15"+"\n"+get_name_dia(fechadia15)
      row << "16"+"\n"+get_name_dia(fechadia16)
      row << "17"+"\n"+get_name_dia(fechadia17)
      row << "18"+"\n"+get_name_dia(fechadia18)
      row << "19"+"\n"+get_name_dia(fechadia19)
      row << "20"+"\n"+get_name_dia(fechadia20)
      row << "21"+"\n"+get_name_dia(fechadia21)
      row << "22"+"\n"+get_name_dia(fechadia22)
      row << "23"+"\n"+get_name_dia(fechadia23)
      row << "24"+"\n"+get_name_dia(fechadia24)
      row << "25"+"\n"+get_name_dia(fechadia25)
      row << "26"+"\n"+get_name_dia(fechadia26)
      row << "27"+"\n"+get_name_dia(fechadia27)
      row << "28"+"\n"+get_name_dia(fechadia28)
      if fechadia29 != ""
        row << "29"+"\n"+get_name_dia(fechadia29)
      end
      if fechadia30 != ""
        row << "30"+"\n"+get_name_dia(fechadia30)
      end
      if fechadia31 != ""
        row << "31"+"\n"+get_name_dia(fechadia31)
      end
      row << "NRO. 
        DIAS"

      row << "COSTO"
      row << "IMPORTE"


     table_content << row

     for  order in @orden_detalle
            row = []
            row << order.website
            row << order.medio_detail.name[0..14]
            row << @orden.version.descrip 
          
            row << order.tarifa_cpm
            row << order.impresion_click

            row << formatea_number(order.d01)
            row << formatea_number(order.d02)
            row << formatea_number(order.d03)
            row << formatea_number(order.d04)
            row << formatea_number(order.d05)
            row << formatea_number(order.d06)
            row << formatea_number(order.d07)
            row << formatea_number(order.d08)
            row << formatea_number(order.d09)
            row << formatea_number(order.d10)
            row << formatea_number(order.d11)
            row << formatea_number(order.d12)
            row << formatea_number(order.d13)
            row << formatea_number(order.d14)
            row << formatea_number(order.d15)
            row << formatea_number(order.d16)
            row << formatea_number(order.d17)
            row << formatea_number(order.d18)
            row << formatea_number(order.d19)
            row << formatea_number(order.d20)
            row << formatea_number(order.d21)
            row << formatea_number(order.d22)
            row << formatea_number(order.d23)
            row << formatea_number(order.d24)
            row << formatea_number(order.d25)
            row << formatea_number(order.d26)
            row << formatea_number(order.d27)
            row << formatea_number(order.d28)
            if fechadia29 != ""
              row << formatea_number(order.d29)
            end
            if fechadia30 != ""
              row << formatea_number(order.d30)
            end
            if fechadia31 != ""
              row << formatea_number(order.d31)
            end


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
           
            row << money(order.price)

            row << money(order.total)

            table_content << row
             @total_linea_general += @total_linea
             @total_linea = 0
          nroitem = nroitem + 1

       end



        row = []
         row << "TOTAL =>"
         row << "  "
         row << "  "
         row << "  "
         row << "  "

         row << formatea_number(@total_dia01_column)
         row << formatea_number(@total_dia02_column)
         row << formatea_number(@total_dia03_column)
         row << formatea_number(@total_dia04_column)
         row << formatea_number(@total_dia05_column)
         row << formatea_number(@total_dia06_column)
         row << formatea_number(@total_dia07_column)
         row << formatea_number(@total_dia08_column)
         row << formatea_number(@total_dia09_column)
         row << formatea_number(@total_dia10_column)
         row << formatea_number(@total_dia11_column)
         row << formatea_number(@total_dia12_column)
         row << formatea_number(@total_dia13_column)
         row << formatea_number(@total_dia14_column)
         row << formatea_number(@total_dia15_column)
         row << formatea_number(@total_dia16_column)
         row << formatea_number(@total_dia17_column)
         row << formatea_number(@total_dia18_column)
         row << formatea_number(@total_dia19_column)
         row << formatea_number(@total_dia20_column)
         row << formatea_number(@total_dia21_column)
         row << formatea_number(@total_dia22_column)
         row << formatea_number(@total_dia23_column)
         row << formatea_number(@total_dia24_column)
         row << formatea_number(@total_dia25_column)
         row << formatea_number(@total_dia26_column)
         row << formatea_number(@total_dia27_column)
         row << formatea_number(@total_dia28_column)
          if fechadia29 != ""
             row << formatea_number(@total_dia29_column)
          end
             if fechadia30 != ""
           row << formatea_number(@total_dia30_column)
         end
            if fechadia31 != ""
           row << formatea_number(@total_dia31_column)
         end

           row << sprintf("%.2f",@total_linea_general.to_s)
           row << " "
         row << " "
   

         table_content << row

        result = pdf.table table_content, {:position => :center,
                                        :header => true,
                                        :width => pdf.bounds.width

                                        } do
                                          columns([0]).align=:left                                        
                                          columns([0]).width = 50 
                                          columns([1]).align =:left
                                          columns([1]).width = 50 

                                          columns([2]).align=:center
                                          columns([2]).width = 80

                                          columns([3]).align=:center
                                          columns([3]).width = 30

                                          columns([4]).align=:center
                                          columns([4]).width = 30 

                                          columns([5]).align=:center
                                          columns([5]).width = 30
                                          columns([6]).align=:center
                                          
                                          columns([7]).align=:center

                                          columns([8]).align=:center

                                          columns([9]).align=:center

                                          columns([10]).align=:center

                                          columns([11]).align=:center

                                          columns([12]).align=:center

                                          columns([13]).align=:center

                                          columns([14]).align=:center

                                          columns([15]).align=:center

                                          columns([16]).align=:center

                                          columns([17]).align=:center

                                          columns([18]).align=:center

                                          columns([19]).align=:center

                                          columns([20]).align=:center

                                          columns([21]).align=:center

                                          columns([22]).align=:center


                                          columns([23]).align=:center

                                          columns([24]).align=:center

                                          columns([25]).align=:center

                                          columns([26]).align=:center

                                          columns([27]).align=:center

                                          columns([28]).align=:center

                                          columns([29]).align=:center
                                          columns([30]).align=:center


                                          columns([31]).align=:center

                                          columns([32]).align=:right


                                          columns([33]).align=:right

                                      

                                          columns([34]).align=:right
                                       


                                          columns([35]).align=:right
                                      
                                          columns([35]).width = 30 

                                          columns([36]).align=:right
                                          columns([36]).width = 30 
                                          
                                          columns([37]).align=:right                                      
                                          columns([37]).width = 30 
                                          
                                          columns([38]).align=:right
                                          columns([38]).width = 30 


                                          columns([39]).align=:right
                                          columns([39]).width = 30 

                                          columns([40]).align=:right
                                          columns([40]).width = 30 
                                                                                     


          end
      pdf

    end


    def build_pdf_footer_rpt2(pdf)
        pdf.font "Helvetica" , :size => 6

        subtotals = []
        taxes = []
        totals = []
        services_subtotal = 0
        services_tax = 0
        services_total = 0

        pdf.move_down 2
        lcTexto=     "Los espacios,fechas y ubicaciones no seran modificados sin permiso de la agencia.No se ubicarán en la misma tanda/página, al lado, al frente o a continuación de otra publicación de similares"

        data =[ ["Observaciones:" + @orden.description," ",""],

               [lcTexto,"Departamento de  medios.
               Firma.
               ","Recibido por el medio. "]          ]

            pdf.text " "


        table_content = [["This table"], ["covers the"], ["whole page width"]]


        pdf.table invoice_summary, {
            :position => :right,
            :cell_style => {:border_width => 1},
            :width => pdf.bounds.width/8
          } do
            columns([0]).font_style = :bold
            columns([1]).align = :right

          end


       # pdf.table(data,:cell_style=> {:border_width=>1} ,:width => pdf.bounds.width/2,:position=> :center )

        pdf.text ""
        pdf.bounding_box([0, 70],:width => pdf.bounds.width, :height => 70,:position=> :center) do
        #pdf.draw_text "Company: #{@company.name} - Created with: #{getAppName()} - #{getAppUrl()}", :at => [pdf.bounds.left, pdf.bounds.bottom ]
            pdf.table data, {
            :position => :center,
            :cell_style => {:border_width => 1},
            :width => pdf.bounds.width
          } do
            columns([0]).font_style = :bold
            columns([0]).width  = 250
            columns([1]).align = :center
            columns([2]).align = :center
          end

      end

      pdf
      #
  end



  # Reporte de orden
  def pdf
    @orden = Orden.find(params[:id])
    @company = Company.find(1)

     $lcContrato =  @orden.contrato.code
     $lcMedio  = @orden.medio.descrip
     $lcMarca  = @orden.marca.name
     $lcProducto = @orden.producto.name
     $lcVersion = @orden.version.descrip
     $lcFechaMes = @orden.month.to_i
     $lcDuracion = @orden.tiempo
     @months = monthsArr
     @month_name = @months[$lcFechaMes - 1][0] <<" - " << @orden.year.to_s

     $lcMoneda = @orden.get_moneda(@orden.moneda_id)
     $lcMedio = @orden.medio.descrip
     $lcCobertura = @orden.ciudad.descrip

      @customer = @orden.customer
    #:margin => [2,2,5,2]


     if @orden.tipo_orden_id == 2 or @orden.tipo_orden_id == 6 or @orden.tipo_orden_id == 4
 
       Prawn::Document.generate "app/pdf_output/rpt_orden2.pdf" , :page_layout => :landscape,:size=> "A3", :margin => [1,10,50,20] do |pdf|
         pdf.font "Helvetica"
        pdf = build_pdf_header_rpt2(pdf)
         pdf = build_pdf_body_rpt20(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"
      end 


      end 


     if @orden.tipo_orden_id == 3
 
       Prawn::Document.generate "app/pdf_output/rpt_orden2.pdf" , :page_layout => :landscape,:size=> "A3", :margin => [1,10,50,20] do |pdf|
         pdf.font "Helvetica"
         pdf = build_pdf_header_rpt2(pdf)
         pdf = build_pdf_body_rpt30(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"
      end 


      end 

   if @orden.tipo_orden_id == 5
 
       Prawn::Document.generate "app/pdf_output/rpt_orden2.pdf" , :page_layout => :landscape,:size=> "A3", :margin => [1,10,50,20] do |pdf|
         pdf.font "Helvetica"
         pdf = build_pdf_header_rpt2(pdf)
         pdf = build_pdf_body_rpt50(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"
      end 


      end 
 


   if @orden.tipo_orden_id == 7
 
       Prawn::Document.generate "app/pdf_output/rpt_orden2.pdf" , :page_layout => :landscape,:size=> "A3", :margin => [1,10,50,20] do |pdf|
         pdf.font "Helvetica"
         pdf = build_pdf_header_rpt2(pdf)
         pdf = build_pdf_body_rpt70(pdf)
        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"
      end 


      end 


   if @orden.tipo_orden_id == 1  
        


    Prawn::Document.generate "app/pdf_output/rpt_orden2.pdf" , :page_layout => :landscape,:size=> "A3",:margin => [1,10,50,20] do |pdf|

        pdf.font "Helvetica"
        pdf = build_pdf_header_rpt2(pdf)
        pdf = build_pdf_body_rpt10(pdf)
 

        build_pdf_footer_rpt2(pdf)

        $lcFileName =  "app/pdf_output/rpt_orden2.pdf"

    end


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
    if params[:orden_id] == "D"
     @products = Avisodetail.where(["(descrip iLIKE ? and category_program_id = 3 )", "%" +params[:q] + "%"])
    else
     @products = Avisodetail.where(["(descrip iLIKE ? and category_program_id <> 3 )", "%" +params[:q] + "%"])
    end

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
    @pagetitle = "#{@company.name} - Products"
    @filters_display = "block"

    @customers = Customer.all.order(:name)
    @motivos =Motivo.all.order(:name)
    @medios = Medio.all.order(:descrip)
    @marcas= Marca.all.order(:name)
    @versions = Version.all.order(:descrip)
    @contratos = Contrato.all
    @productos = Producto.all.order(:name)

    if(@company.can_view(current_user))

            
#        if(params[:search] and params[:search] != "")
 #         @ordens = Orden.where(["company_id = ? and (code iLIKE ?)", @company.id ,"%" + params[:search] + "%" ]).order('fecha DESC').paginate(:page => params[:page])
       
        if(params[:q] and params[:q] != "")
       
          q = params[:q].strip
          @q_org = q

          query = params[:q]

      

          @ordens = Orden.find_by_sql(['Select ordens.*, customers.name 
                      from ordens 
                      INNER JOIN customers ON ordens.customer_id = customers.id
                      where customers.name iLIKE ? or ordens.code ilike ?',"%" + query + "%" , "%" + query + "%"   ] ).paginate(:page => params[:page])


        else
          @ordens = Orden.where(["company_id = ?",@company.id ]).order('fecha desc , code desc').paginate(:page => params[:page])
           @filters_display = "none"
        end
  
    end 

  end


  # GET /ordens
  # GET /ordens.xml
  def index
    @companies = Company.where(user_id: current_user.id).order("fecha, code DESC")
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
    @productos = Producto.all
    @ciudad = Ciudad.all

    anio = @orden.year
    mes = @orden.month 
 days_mes = days_of_month(mes,anio)

@fechadia1 = anio.to_s << "-" << mes.to_s.rjust(2, '0') << "-" << "01"
@fechadia2 = anio.to_s << "-" << mes.to_s << "-" << "02"
@fechadia3 = anio.to_s << "-" << mes.to_s << "-" << "03"
@fechadia4 = anio.to_s << "-" << mes.to_s << "-" << "04"
@fechadia5 = anio.to_s << "-" << mes.to_s << "-" << "05"
@fechadia6 = anio.to_s << "-" << mes.to_s << "-" << "06"
@fechadia7 = anio.to_s << "-" << mes.to_s << "-" << "07"
@fechadia8 = anio.to_s << "-" << mes.to_s << "-" << "08"
@fechadia9 = anio.to_s << "-" << mes.to_s << "-" << "09"
@fechadia10 = anio.to_s << "-" << mes.to_s << "-" << "10"
@fechadia11 = anio.to_s << "-" << mes.to_s << "-" << "11"
@fechadia12 = anio.to_s << "-" << mes.to_s << "-" << "12"
@fechadia13 = anio.to_s << "-" << mes.to_s << "-" << "13"
@fechadia14 = anio.to_s << "-" << mes.to_s << "-" << "14"
@fechadia15 = anio.to_s << "-" << mes.to_s << "-" << "15"
@fechadia16 = anio.to_s << "-" << mes.to_s << "-" << "16"
@fechadia17 = anio.to_s << "-" << mes.to_s << "-" << "17"
@fechadia18 = anio.to_s << "-" << mes.to_s << "-" << "18"
@fechadia19 = anio.to_s << "-" << mes.to_s << "-" << "19"
@fechadia20 = anio.to_s << "-" << mes.to_s << "-" << "20"
@fechadia21 = anio.to_s << "-" << mes.to_s << "-" << "21"
@fechadia22 = anio.to_s << "-" << mes.to_s << "-" << "22"
@fechadia23 = anio.to_s << "-" << mes.to_s << "-" << "23"
@fechadia24 = anio.to_s << "-" << mes.to_s << "-" << "24"
@fechadia25 = anio.to_s << "-" << mes.to_s << "-" << "25"
@fechadia26 = anio.to_s << "-" << mes.to_s << "-" << "26"
@fechadia27 = anio.to_s << "-" << mes.to_s << "-" << "27"

if days_mes >=28
        @fechadia28 = anio.to_s << "-" << mes.to_s << "-" << "28"
      else
        @fechadia28=""
      end
      if days_mes >=29
        @fechadia29 = anio.to_s << "-" << mes.to_s << "-" << "29"
      else
        @fechadia29=""
      end
      if days_mes >=30
        @fechadia30 = anio.to_s << "-" << mes.to_s << "-" << "30"
      else
        @fechadia30=""
      end
      if days_mes >=31
        @fechadia31 = anio.to_s << "-" << mes.to_s << "-" << "31"
      else
        @fechadia31=""
      end



    @ordens_products = @orden.orden_products.order(:id)
  end

  # GET /ordens/new
  # GET /ordens/new.xml




  def new
    @pagetitle = "New orden"
    @action_txt = "Create"
    

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


    @customers = Customer.all.order(:name)
    @motivos =Motivo.all.order(:name)
    @medios = Medio.all.order(:descrip)
    @marcas= Marca.all.order(:name)
    @versions = Version.all.order(:descrip)
    @contratos = Contrato.all
    @productos = Producto.all.order(:name)


    @orden = Orden.new
    @orden[:code] = "#{generate_guid12()}"

    @orden[:processed] = false
    @orden[:tiempo] = 30
    @orden[:fecha] = Date.today

    @orden[:ciudad_id]  = 1
    
    @company = Company.find(params[:company_id])
    @orden.company_id = @company.id

    @monedas = Moneda.all

    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
    @tipo_ordens = @company.get_tipo_orden()

    @tipo_avisos = @company.get_tipo_aviso()
    @tipo_tafifas = @company.get_tipo_tarifa()


    @ciudad = Ciudad.all

    @contratos2 = @company.get_customer_contratos()


    

    @ac_user = getUsername()
    @orden[:user_id] = getUserId()
  end

  def neworden
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
      @productos = Producto.all

      @orden = Orden.new
      @orden[:code] = "#{generate_guid12()}"

      @orden[:processed] = false
      @orden[:tiempo] = 0
      @orden[:fecha] = Date.today
      @orden[:fecha_inicio] = Date.today
      @orden[:fecha_fin] = Date.today
      @company = Company.find(1)
      @orden.company_id = @company.id
      @orden[:tarifa] = 0.00

      @locations = @company.get_locations()
      @divisions = @company.get_divisions()
      @ciudad = Ciudad.all

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
    @contratos2 = CustomerContrato.all.order(:secu_cont)


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



    @year = @orden.year
    @month = @orden.month

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
    @productos = Producto.all
    @ciudad = Ciudad.all
    @contratos2 = @company.get_customer_contratos()
    @monedas = Moneda.all
   @tipo_ordens = @company.get_tipo_orden()


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
    @productos = Producto.all
    @ciudad = Ciudad.all
    @monedas = Moneda.all
        @contratos2 = @company.get_customer_contratos()

 @tipo_ordens = @company.get_tipo_orden()


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

    @orden[:processed] = "1"
    @orden[:tipo] = "N"
    @orden[:contrato_id] = 1449
    @orden[:tiempo] = 30
    @orden[:ciudad_id]  = 1
    
    respond_to do |format|
      if @orden.save
        # Create products for kit
        #@orden.add_products(items)

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

    @company = Company.find(1)
    
    @pagetitle = "Edit orden"
    @action_txt = "Update"
    @customers = Customer.all
    @motivos =Motivo.all
    @medios = Medio.all
    @marcas= Marca.all
    @versions = Version.all
    @contratos = Contrato.all
        @contratos2 = @company.get_customer_contratos()


    items = params[:items].split(",")

    @orden =Orden.find(params[:id])
    @company = Company.find(1)

    if(params[:ac_customer] and params[:ac_customer] != "")
      @ac_customer = params[:ac_customer]
    else
      @ac_customer = @orden.customer.name
    end


    @locations = @company.get_locations()
    @divisions = @company.get_divisions()
 @tipo_ordens = @company.get_tipo_orden()

     @orden.calcularTarifa(params[:orden][:tiempo])
     @orden[:month] = params[:month]
     @orden[:year] = params[:year]

     @orden[:subtotal] = @orden.get_subtotal("subtotal")
     @orden[:tax] = @orden.get_subtotal("tax")
     @orden[:total] = @orden[:subtotal] + @orden[:tax]

    respond_to do |format|
      if @orden.update_attributes(orden_params)

          #@orden.calcularTarifa(@orden.tiempo)
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



####################################################################

def crear
    @pagetitle = "Nueva Orden Digital "
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
    @productos = Producto.all
    @ciudad = Ciudad.all

    @orden[:month]= @month
    @orden[:year]= @year
    @orden[:customer_id]= params[:orden][:customer_id]
    @orden[:avisodetail_id]= params[:orden][:avisodetail_id]
    @orden[:processed] = "1"
    @orden[:tipo] = "D"
    @orden[:subtotal] = params[:orden][:tarifa]

    @orden[:total] = @orden[:subtotal] * 1.18

    @orden[:tax] = @orden[:total] - @orden[:subtotal]

    if(params[:orden][:user_id] and params[:orden][:user_id] != "")
      curr_seller = User.find(params[:orden][:user_id])
      @ac_user = curr_seller.username
    end

    respond_to do |format|
    if  @orden.save

        @orden.add_digital()

        @orden.process()
        @orden.correlativo()

        format.html { redirect_to(@orden, :notice => 'Orden fue creada con exito.') }
        format.xml  { render :xml => @orden, :status => :created, :location => @orden }
      else
        format.html { render :action => "neworden" }
        format.xml  { render :xml => @orden.errors, :status => :unprocessable_entity }
      end
    end
  end



####################################################################

  # reporte completo
  def build_pdf_header_rpt5(pdf)
      pdf.font "Helvetica" , :size => 8
     $lcCli  =  @company.name
     $lcdir1 = @company.address1+@company.address2+@company.city

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

    pdf.text "Listado de Ordenes.   Mes:"+ @mes.to_s + " Año : "+@anio.to_s , :size => 8

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

      @subtotal = 0
      @tax = 0
      @total  = 0

      nroitem = 1


       for  product in @ordenes_rpt


            row = []
            row << nroitem.to_s
            if product.contrato != nil
            row << product.contrato.code
            else
            row << ""
            end
            if product.contrato != nil
            row << product.contrato.customer.name
            else
              row << ""
            end
            row << product.medio.descrip
            row << product.marca.name

            row << product.producto.name

            row << product.version.descrip
            row << product.tiempo
            row << product.subtotal


            table_content << row

            @subtotal += product.subtotal
            @tax += product.tax
            @total += product.total

            nroitem=nroitem + 1

        end


            row = []
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            row << ""
            row << "TOTAL => "
            row << ""
            row << money(@subtotal)
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


  def rpt_ordenes1_pdf

    @company=Company.find(1)
    @mes = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]

    @marca= Marca.find_by("id = ?", params[:marca_id]).order(:name)

    @cliente_check = params[:check_cliente]
    @medio_check = params[:check_medio]
    @producto_check = params[:check_producto]
    @marca_check = params[:check_marca]
    @version_check = params[:check_version]
    @ciudad_check = params[:check_ciudad]
    @tipoorden_check = params[:check_tipoorden]


    if @cliente_check == "true"
      @customer = ""
      @customer_name = ""
    else
      @customer = params[:customer_id]
      @customer_name =  @company.get_cliente_name(@customer)
    end

    if @medio_check == "true"
        @medio=""
    else
        @medio =params[:medio_id]
    end


    if @producto_check == "true"
      @producto=""
    else
      @producto =params[:producto_id]
    end

    if @marca_check == "true"
        @marca=""
    else
        @marca =params[:marca_id]
    end

    if @version_check == "true"
      @version = ""
    else
      @version =params[:version_id]
    end
    if @ciudad_check == "true"
      @ciudad = ""
    else
      @ciudad =params[:ciudad_id]
    end

    if @tipoorden_check == "true"
      @tipoorden =""
    else
      @tipoorden = params[:tipo]
    end




    @ordenes_rpt = @company.get_ordenes_cliente_all(@mes,@anio,@mes1,@anio1,@customer,@medio,@marca,@producto,@version,@ciudad,@tipoorden)


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


def foot_data_headers_1

    #{@purchaseorder.description}

     client_data_headers_1  = [["Cliente : ", $lcCli]]
      client_data_headers_1 <<  ["RUC : ", $lcRucCli]
      client_data_headers_1 <<  ["Direccion : ", $lcDircli]
      client_data_headers_1 <<  ["Contrato : ", $lcContrato]
      client_data_headers_1


  end




 def client_data_headers_1

    #{@purchaseorder.description}


      client_data_headers_1  = [ ["Medio : ", @orden.medio.descrip ]]
      client_data_headers_1 <<   ["Cliente : ",@customer.name ]
      client_data_headers_1 <<   ["Direccion : ",@customer.address1  ]
      client_data_headers_1 <<   ["Marca : ", @orden.marca.name  ]
     
      client_data_headers_1


  end

  def invoice_headers_1

    invoice_headers_1  = [["",""]]
      invoice_headers_1 << ["Moneda : ", @orden.moneda.description ]
     
      invoice_headers_1
  end

 def invoice_headers_2
      invoice_headers_2  = [["",""]]
      invoice_headers_2 << ["Estado : ",@orden.get_processed]
      invoice_headers_2 << ["Contrato Nro. : ",@orden.get_nro_contrato(@orden.secu_cont) ]

      invoice_headers_2 << ["Tipo de Orden : ",@orden.tipo_orden.descrip ]

  

      invoice_headers_2


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
      invoice_summary << ["SubTotal :", money(@orden.subtotal) ]
      invoice_summary << ["IGV    : ",money(@orden.tax) ]
      invoice_summary << ["Total  : ", money(@orden.total) ]

      invoice_summary
    end

   def invoice_summary2
      invoice_summary2 = []
      invoice_summary2 << ["SubTotal",  ActiveSupport::NumberHelper::number_to_delimited(@orden.subtotal,delimiter:",",separator:".").to_s]
      invoice_summary2 << ["IGV",ActiveSupport::NumberHelper::number_to_delimited(@orden.tax,delimiter:",",separator:".").to_s]
      invoice_summary2 << ["Total", ActiveSupport::NumberHelper::number_to_delimited(@orden.total ,delimiter:",",separator:".").to_s]

      invoice_summary2
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


     puts "update versions..."
     puts @versions.last.descrip

  end

   def reportes

     @company=Company.find(1)
    @mes  = params[:month]
    @anio = params[:year]
    @mes1 = params[:month1]
    @anio1 = params[:year1]

      @marca= Marca.find_by("id = ?", params[:marca_id])

    @cliente_check = params[:check_cliente]
    @medio_check = params[:check_medio]
    @marca_check = params[:check_marca]
    @producto_check = params[:check_producto]
    @version_check = params[:check_version]
    @ciudad_check = params[:check_ciudad]
    @tipoorden_check = params[:check_tipoorden]


    if @cliente_check == "true"
      @customer = ""
      @customer_name = ""
    else
      @customer = params[:customer_id]
      @customer_name =  @company.get_cliente_name(@customer)
    end


    if @producto_check == "true"
      @producto=""
    else
      @producto =params[:producto_id]
    end
    if @medio_check == "true"
        @medio=""
    else
        @medio =params[:medio_id]
    end

    if @marca_check == "true"
        @marca=""
    else
        @marca =params[:marca_id]
    end

    if @version_check == "true"
      @version = ""
    else
      @version =params[:version_id]
    end
    if @ciudad_check == "true"
      @ciudad = ""
    else
      @ciudad =params[:ciudad_id]
    end

    if @tipoorden_check == "true"
      @tipoorden =""
    else
      @tipoorden = params[:tipo]
    end
    

   


        case params[:print]
          when "To PDF" then
            begin

               @ordenes_rpt = @company.get_ordenes_cliente_all(@mes.to_i ,@anio.to_i,@mes1.to_i,@anio1.to_i,@customer,@medio,@marca,@producto,@version,@ciudad,@tipoorden)

             render  pdf: "Ordenes ",template: "ordens/orden_rpt2.pdf.erb",locals: {:orden => @ordenes_rpt}

            end
          when "To Excel" then 

            begin

            @ordenes = @company.get_ordenes_cliente_all0(@mes.to_i ,@anio.to_i,@mes1.to_i,@anio1.to_i,@customer,@medio,@marca,@producto,@version,@ciudad,@tipoorden)

            render xlsx: 'rpt_corden_01'
            end 

          else render action: "index"
        end



  end

  def import
      Orden.import(params[:file])
       redirect_to root_url, notice: "Contratos importados."
  end



  #**************************************************************************+++++++++++++++++++++
  #
  #**************************************************************************+++++++++++++++++++++

 def rpt_ccobrar10 
  
    $lcxCliente ="1"
    @company=Company.find(1)      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]
    @customer= params[:customer_id]

    lcmonedadolares ="1"
    lcmonedasoles ="2"
    @medio_check = params[:check_medio]  
    puts "valor medio checkl "
    puts @medio_check
 

    if @medio_check == "true"
     
        @medio = ""
        @medio_name = ""
        @contratos_rpt = @company.get_contratos_medio1(@fecha1,@fecha2)

    else
       @medio = params[:medio_id]
       @medio_name = ""
       @medio_name =  @company.get_medio_name(@medio)
       @contratos_rpt = @company.get_contratos_medio_canal1(@fecha1,@fecha2,@medio)

    end



    case params[:print]
      when "PDF" then 
       begin 
         render  pdf: "Contratos ",template: "supplier_payments/rpt_ccobrar10.pdf.erb",locals: {:contrato => @contratos_rpt},
          :orientation => 'Landscape',
         :header => {
           :spacing => 5,
                           :html => {
                           :template => 'layouts/pdf-header4.html', 
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



  #**************************************************************************+++++++++++++++++++++
  #
  #**************************************************************************+++++++++++++++++++++

 def rpt_ccobrar20
  
    $lcxCliente ="1"
    @company=Company.find(1)      
    @fecha1 = params[:fecha1]    
    @fecha2 = params[:fecha2]
    @customer= params[:customer_id]

    lcmonedadolares ="1"
    lcmonedasoles ="2"
    @medio_check = params[:check_medio]  
    puts "valor medio checkl "
    puts @medio_check
 

    if @medio_check == "true"
     
        @medio = ""
        @medio_name = ""
        @contratos_rpt = @company.get_contratos_medio2(@fecha1,@fecha2)

    else
       @medio = params[:medio_id]
       @medio_name = ""
       @medio_name =  @company.get_medio_name(@medio)
       @contratos_rpt = @company.get_contratos_medio_canal2(@fecha1,@fecha2,@medio)

    end


    case params[:print]
      when "PDF" then 
       begin 
         render  pdf: "Contratos ",template: "supplier_payments/rpt_ccobrar20.pdf.erb",locals: {:contrato => @contratos_rpt},
          :orientation => 'Landscape',
         :header => {
           :spacing => 5,
                           :html => {
                           :template => 'layouts/pdf-header4.html', 
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


 def xls

   @company = Company.find(1)
   @orden = Orden.find(params[:id])
   @nro_items =  @orden.get_orden_products_items()
   @orden_detalle =  @orden.get_orden_products()

   

   if @orden.tipo_orden_id == 1
    render xlsx: 'orden_xls'
   end 

   if @orden.tipo_orden_id == 2
    render xlsx: 'orden2_xls'
   end 
   if @orden.tipo_orden_id == 3
    render xlsx: 'orden3_xls'
   end 
   if @orden.tipo_orden_id == 4
    render xlsx: 'orden4_xls'
   end 
   if @orden.tipo_orden_id == 5
    render xlsx: 'orden5_xls'
   end 
  if @orden.tipo_orden_id == 6
    render xlsx: 'orden6_xls'
   end 
  if @orden.tipo_orden_id == 7
    render xlsx: 'orden7_xls'
   end 



 end 




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden
      @orden = Orden.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_params

    params.require(:orden).permit(:contrato_id , :fecha, :medio_id , :marca_id,:version_id,
    :fecha1, :fecha2, :tiempo, :code , :company_id , :subtotal, :tax, :total, :user_id ,
    :processed , :customer_id, :description, :rating , :month, :year, :revision, :producto_id,
    :ciudad_id,:fecha_inicio, :fecha_fin, :tarifa , :aviso_detail_id, :avisodetail_id,
    :tipo, :secu_cont, :moneda_id, :quantity,:tipo_orden_id )


    end


end
