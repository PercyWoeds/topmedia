class Ordens::OrdensProductsController < ApplicationController
   before_action :set_orden
   before_action :set_orden_product, :except=> [:new,:create,:import ]

  # GET /orden_products/1
  # GET /orden_products/1.json

  # GET /orden_products/new
  def new

    @orden_product = OrdenProduct.new
    @company = Company.find(1)
    @orden_product.d01 = 0
    @orden_product.d02 = 0
    @orden_product.d03 = 0
    @orden_product.d04 = 0
    @orden_product.d05 = 0
    @orden_product.d06 = 0
    @orden_product.d07 = 0
    @orden_product.d08 = 0
    @orden_product.d09 = 0
    @orden_product.d10 = 0
    @orden_product.d11 = 0
    @orden_product.d12 = 0
    @orden_product.d13 = 0
    @orden_product.d14 = 0
    @orden_product.d15 = 0
    @orden_product.d16 = 0
    @orden_product.d17 = 0
    @orden_product.d18 = 0
    @orden_product.d19 = 0
    @orden_product.d20 = 0
    @orden_product.d21 = 0
    @orden_product.d22 = 0
    @orden_product.d23 = 0
    @orden_product.d24 = 0
    @orden_product.d25 = 0
    @orden_product.d26 = 0
    @orden_product.d27 = 0
    @orden_product.d28 = 0
    @orden_product.d29 = 0
    @orden_product.d30 = 0
    @orden_product.d31 = 0
    @orden_product.quantity = 0
    @orden_product.tarifa = 0
    @orden_product.price = 0
    @orden_product.total = 0
    @orden_product.duracion = 20
    @orden_product.cobertura = "NACIONAL"

   @orden_product.horario = "06:00 - 24:00"

   @orden_product.nro_salas = 0
   @orden_product.nro_semanas  = 0

   
    @orden_product.avisodetail_id = 3517


    @orden_product_medio_details = @orden_product.get_medio_details(@orden.medio_id )

    @tipo_avisos = @company.get_tipo_aviso()
    @tipo_tarifas = @company.get_tipo_tarifa()

    @tipo_cpms = TipoCpm.all 
    @tipo_formatos = TipoFormato.all 

anio = @orden.year
    mes = @orden.month 
 days_mes = days_of_month(mes,anio)

 last_day = @orden.days_in_month(@orden.month,@orden.year )  

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

  end

  # GET /orden_products/1/edit
  def edit
    @company = Company.find(1)
    @aviso = Avisodetail.find(@orden_product.avisodetail_id)
    @ac_item = @aviso.descrip
    @ac_item_id = @aviso.id

    @tipo_avisos = @company.get_tipo_aviso()
    @tipo_tarifas = @company.get_tipo_tarifa()

    @tipo_cpms = TipoCpm.all 
    @tipo_formatos = TipoFormato.all 


    @orden_product_medio_details = @orden_product.get_medio_details(@orden.medio_id )
  
    anio = @orden.year
    mes = @orden.month 
    days_mes = days_of_month(mes,anio)
 last_day = @orden.days_in_month(@orden.month,@orden.year )  

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

  end

  # POST /orden_products
  # POST /orden_products.json
  def create

    @company = Company.find(1)

    @orden_product = OrdenProduct.new(orden_product_params)

    @orden_product.orden_id  = @orden.id
     puts "createee+++++++++++++++++++++++++++++"

    if @orden.tipo_orden_id == 1

        @orden_product.avisodetail_id = 3517
        @orden_product.price = @orden_product.tarifa 
        sum_dias = 1
        @orden_product.quantity = sum_dias
       

    end 

 
    if @orden.tipo_orden_id == 2 or @orden.tipo_orden_id == 6  or @orden.tipo_orden_id == 7

        @orden_product.avisodetail_id = 3517

        sum_dias = (@orden_product.d01 + @orden_product.d02 + @orden_product.d03 + @orden_product.d04+
                    @orden_product.d05 + @orden_product.d06 + @orden_product.d07 + @orden_product.d08+
                    @orden_product.d09 + @orden_product.d10 + @orden_product.d11 + @orden_product.d12+
                    @orden_product.d13 + @orden_product.d14 + @orden_product.d15 + @orden_product.d16+
                    @orden_product.d17 + @orden_product.d18 + @orden_product.d19 + @orden_product.d20+
                    @orden_product.d21 + @orden_product.d22 + @orden_product.d23 + @orden_product.d24+
                    @orden_product.d25 + @orden_product.d26 + @orden_product.d27 + @orden_product.d28+
                    @orden_product.d29 + @orden_product.d30 + @orden_product.d31)

        @orden_product.quantity = sum_dias
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 

    end 

    if @orden.tipo_orden_id == 3

        @orden_product.avisodetail_id = 3517

        sum_dias = (@orden_product.d01 + @orden_product.d02 + @orden_product.d03 + @orden_product.d04+
                    @orden_product.d05 + @orden_product.d06 + @orden_product.d07 + @orden_product.d08+
                    @orden_product.d09 + @orden_product.d10 + @orden_product.d11 + @orden_product.d12+
                    @orden_product.d13 + @orden_product.d14 + @orden_product.d15 + @orden_product.d16+
                    @orden_product.d17 + @orden_product.d18 + @orden_product.d19 + @orden_product.d20+
                    @orden_product.d21 + @orden_product.d22 + @orden_product.d23 + @orden_product.d24+
                    @orden_product.d25 + @orden_product.d26 + @orden_product.d27 + @orden_product.d28+
                    @orden_product.d29 + @orden_product.d30 + @orden_product.d31)

        @orden_product.quantity = sum_dias
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 

    end 

    if @orden.tipo_orden_id == 4 

        @orden_product.avisodetail_id = 3517
         @orden_product.tarifa   = 0 
        sum_dias = (@orden_product.d01 + @orden_product.d02 + @orden_product.d03 + @orden_product.d04+
                    @orden_product.d05 + @orden_product.d06 + @orden_product.d07 + @orden_product.d08+
                    @orden_product.d09 + @orden_product.d10 + @orden_product.d11 + @orden_product.d12+
                    @orden_product.d13 + @orden_product.d14 + @orden_product.d15 + @orden_product.d16+
                    @orden_product.d17 + @orden_product.d18 + @orden_product.d19 + @orden_product.d20+
                    @orden_product.d21 + @orden_product.d22 + @orden_product.d23 + @orden_product.d24+
                    @orden_product.d25 + @orden_product.d26 + @orden_product.d27 + @orden_product.d28+
                    @orden_product.d29 + @orden_product.d30 + @orden_product.d31)

        @orden_product.quantity = sum_dias
        

    end 

    if @orden.tipo_orden_id == 5

        @orden_product.avisodetail_id = 3517

        sum_dias =  @orden_product.quantity 

   
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 

    end 


    @orden_product.total = @orden_product.price * sum_dias
  
    puts @orden_product.total 

     respond_to do |format|
       if @orden_product.save

           @orden[:subtotal] = @orden.get_subtotal("subtotal")
           puts @orden[:subtotal]
           @orden[:tax] = @orden.get_subtotal("tax")
           puts  @orden[:tax] 
           @orden[:total] = @orden[:subtotal] + @orden[:tax]
           puts @orden[:total]

           @orden.update_attributes(:subtotal=> @orden[:subtotal])

         format.html { redirect_to @orden, notice: 'Orden product was successfully created.' }
         format.json { render :show, status: :created, location: @orden }

       else
         format.html { render :new }
         format.json { render json: @orden_product.errors, status: :unprocessable_entity }

       end
     end
  end

  # PATCH/PUT /orden_products/1
  # PATCH/PUT /orden_products/1.json
  def update
    @orden = Orden.find(params[:orden_id])

    @orden_product = OrdenProduct.find(params[:id])

  
    puts @orden_product.tarifa 
    puts @orden.tiempo


  
    @company = Company.find(1)


    if @orden.tipo_orden_id == 1

        @orden_product.avisodetail_id = 3517
        @orden_product.price = @orden_product.tarifa 
        sum_dias = 1
        @orden_product.quantity = sum_dias
       

    end 

 
    if @orden.tipo_orden_id == 2 or @orden.tipo_orden_id == 6  or @orden.tipo_orden_id == 7

        @orden_product.avisodetail_id = 3517


        puts "mmmmm"

        sum_dias = (params[:orden_product][:d01].to_f + params[:orden_product][:d02].to_f +  params[:orden_product][:d03].to_f +  params[:orden_product][:d04].to_f  +
         params[:orden_product][:d05].to_f + params[:orden_product][:d06].to_f +  params[:orden_product][:d07].to_f +  params[:orden_product][:d08].to_f +  
         params[:orden_product][:d09].to_f + params[:orden_product][:d10].to_f +  params[:orden_product][:d11].to_f +  params[:orden_product][:d12].to_f + 
         params[:orden_product][:d13].to_f + params[:orden_product][:d14].to_f +  params[:orden_product][:d15].to_f +  params[:orden_product][:d16].to_f +
         params[:orden_product][:d17].to_f + params[:orden_product][:d18].to_f +  params[:orden_product][:d19].to_f +  params[:orden_product][:d20].to_f +
         params[:orden_product][:d21].to_f + params[:orden_product][:d22].to_f +  params[:orden_product][:d23].to_f +  params[:orden_product][:d24].to_f +
         params[:orden_product][:d25].to_f + params[:orden_product][:d26].to_f +  params[:orden_product][:d27].to_f +  params[:orden_product][:d28].to_f + 
         params[:orden_product][:d29].to_f + params[:orden_product][:d30].to_f +  params[:orden_product][:d31].to_f )

        @orden_product.quantity = sum_dias
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 


         puts "sum dias"
        puts params[:orden_product][:d12].to_f 
         puts sum_dias 


    end 

    if @orden.tipo_orden_id == 3

        @orden_product.avisodetail_id = 3517

       
      sum_dias = (params[:orden_product][:d01].to_f + params[:orden_product][:d02].to_f +  params[:orden_product][:d03].to_f +  params[:orden_product][:d04].to_f  +
         params[:orden_product][:d05].to_f + params[:orden_product][:d06].to_f +  params[:orden_product][:d07].to_f +  params[:orden_product][:d08].to_f +  
         params[:orden_product][:d09].to_f + params[:orden_product][:d10].to_f +  params[:orden_product][:d11].to_f +  params[:orden_product][:d12].to_f + 
         params[:orden_product][:d13].to_f + params[:orden_product][:d14].to_f +  params[:orden_product][:d15].to_f +  params[:orden_product][:d16].to_f +
         params[:orden_product][:d17].to_f + params[:orden_product][:d18].to_f +  params[:orden_product][:d19].to_f +  params[:orden_product][:d20].to_f +
         params[:orden_product][:d21].to_f + params[:orden_product][:d22].to_f +  params[:orden_product][:d23].to_f +  params[:orden_product][:d24].to_f +
         params[:orden_product][:d25].to_f + params[:orden_product][:d26].to_f +  params[:orden_product][:d27].to_f +  params[:orden_product][:d28].to_f + 
         params[:orden_product][:d29].to_f + params[:orden_product][:d30].to_f +  params[:orden_product][:d31].to_f )

        @orden_product.quantity = sum_dias
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 

    end 

    if @orden.tipo_orden_id == 4 

    @orden_product.avisodetail_id = 3517
         @orden_product.tarifa   = 0 
        
         sum_dias = (params[:orden_product][:d01].to_f + params[:orden_product][:d02].to_f +  params[:orden_product][:d03].to_f +  params[:orden_product][:d04].to_f  +
         params[:orden_product][:d05].to_f + params[:orden_product][:d06].to_f +  params[:orden_product][:d07].to_f +  params[:orden_product][:d08].to_f +  
         params[:orden_product][:d09].to_f + params[:orden_product][:d10].to_f +  params[:orden_product][:d11].to_f +  params[:orden_product][:d12].to_f + 
         params[:orden_product][:d13].to_f + params[:orden_product][:d14].to_f +  params[:orden_product][:d15].to_f +  params[:orden_product][:d16].to_f +
         params[:orden_product][:d17].to_f + params[:orden_product][:d18].to_f +  params[:orden_product][:d19].to_f +  params[:orden_product][:d20].to_f +
         params[:orden_product][:d21].to_f + params[:orden_product][:d22].to_f +  params[:orden_product][:d23].to_f +  params[:orden_product][:d24].to_f +
         params[:orden_product][:d25].to_f + params[:orden_product][:d26].to_f +  params[:orden_product][:d27].to_f +  params[:orden_product][:d28].to_f + 
         params[:orden_product][:d29].to_f + params[:orden_product][:d30].to_f +  params[:orden_product][:d31].to_f )
        @orden_product.quantity = sum_dias
        

    end 

    if @orden.tipo_orden_id == 5

        @orden_product.avisodetail_id = 3517

        sum_dias =  @orden_product.quantity 

   
        @orden_product.tarifa   = 0 
         puts "datoos----2 "
         puts  @orden_product.avisodetail_id 
         puts   @orden_product.price
         puts  @orden_product.quantity 

    end 


    @orden_product.total = @orden_product.price * sum_dias
  

    respond_to do |format|
      if @orden_product.update(orden_product_params)

           @orden[:subtotal] = @orden.get_subtotal("subtotal")
           @orden[:tax] = @orden.get_subtotal("tax")
           @orden[:total] = @orden[:subtotal] + @orden[:tax]

           @orden.update_attributes(:subtotal=> @orden[:subtotal])


        format.html { redirect_to @orden, notice: 'Orden product was successfully updated.' }
        format.json { render :show, status: :ok, location: @orden }
      else
        format.html { render :edit }
        format.json { render json: @orden.errors, status: :unprocessable_entity }
      end
    end


  end

  # DELETE /orden_products/1
  # DELETE /orden_products/1.json
  def destroy

    @company = Company.find(1)

    title =@orden_product.avisodetail.descrip

    if @orden_product.destroy
      flash[:notice]= "Item fue eliminado satisfactoriamente "
      redirect_to @orden
    else
      flash[:error]= "Item ha tenido un error y no fue eliminado"
      render :show
    end

  end


  def import

      OrdenProduct.import(params[:file])

        @orden[:subtotal] = @orden.get_subtotal("subtotal")
           @orden[:tax] = @orden.get_subtotal("tax")
           @orden[:total] = @orden[:subtotal] + @orden[:tax]

           @orden.update_attributes(:subtotal=> @orden[:subtotal])

       redirect_to root_url, notice: "Orden importadas"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_orden
      @orden = Orden.find(params[:orden_id])
    end
    def set_orden_product
      @orden_product = OrdenProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def orden_product_params
      params.require(:orden_product).permit(:avisodetail_id, :price, :quantity, :total, :fecha, :tarifa, :i, :dia, :d01, :d02, :d03,
       :d04, :d05, :d06, :d07, :d08, :d09, :d10, :d11, :d12, :d13, :d14, :d15, :d16, :d17, :d18, :d19, :d20, :d21, :d22, :d23, :d24, 
       :d25, :d26, :d27, :d28, :d29, :d30, :d31,:canal,:descrip,:d,:h,:cantidad,:rating,:rating2,:tpp,:impactos,:miles,:impactos2,
       :cpp,:cpm,:cmp2, :duracion ,
     :medidax,
    :ubicacion,
    :ciudad,
    :periodo,
    :detalle,
    :tarifa_cpm,
    :impresion_click,
    :website,
    :nro_salas,
    :nro_semanas,
   :movie,
   :cobertura,
   :horario,
    :tipo_aviso_id,
    :tipo_avisos_id,
    :tipo_tarifa_id,
   :tipo_tarifas_id,
   :medio_detail_id,
   :pelicula,
   :tipo_cpm_id,
   :tipo_formato_id)
  end 
end
