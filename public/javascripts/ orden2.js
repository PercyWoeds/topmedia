// Update price total for invoice

  function updateItemOrden() {


    var dia_01 = $("#orden_product_d01").val();
    var dia_02 = $("#orden_product_d02").val();
    var dia_03 = $("#orden_product_d03").val();
    var dia_04 = $("#orden_product_d04").val();
    var dia_05 = $("#orden_product_d05").val();
    var dia_06 = $("#orden_product_d06").val();
    var dia_07 = $("#orden_product_d07").val();
    var dia_08 = $("#orden_product_d08").val();
    var dia_09 = $("#orden_product_d09").val();
    var dia_10 = $("#orden_product_d10").val();
    var dia_11 = $("#orden_product_d11").val();
    var dia_12 = $("#orden_product_d12").val();
    var dia_13 = $("#orden_product_d13").val();
    var dia_14 = $("#orden_product_d14").val();
    var dia_15 = $("#orden_product_d15").val();
    var dia_16 = $("#orden_product_d16").val();
    var dia_17 = $("#orden_product_d17").val();
    var dia_18 = $("#orden_product_d18").val();
    var dia_19 = $("#orden_product_d19").val();
    var dia_20 = $("#orden_product_d20").val();
    var dia_21 = $("#orden_product_d21").val();
    var dia_22 = $("#orden_product_d22").val();
    var dia_23 = $("#orden_product_d23").val();
    var dia_24 = $("#orden_product_d24").val();
    var dia_25 = $("#orden_product_d25").val();
    var dia_26 = $("#orden_product_d26").val();
    var dia_27 = $("#orden_product_d27").val();
    var dia_28 = $("#orden_product_d28").val();
    var dia_29 = $("#orden_product_d29").val();
    var dia_30 = $("#orden_product_d30").val();
    var dia_31 = $("#orden_product_d31").val();

    alert(dia_01);
       

    var cantidad = dia_01+ dia_02+dia_03+dia_04+dia_05+dia_06+dia_07+dia_08+dia_09+dia_10+
                   dia_11+ dia_12+dia_13+dia_14+dia_15+dia_16+dia_17+dia_18+dia_19+dia_20+ 
                   dia_21+ dia_22+dia_23+dia_24+dia_25+dia_26+dia_27+dia_28+dia_29+dia_30+dia_31 ;

    $("#ac_item_quantity").html(cantidad);

    var quantity = $("#ac_item_quantity").val();
    var tarifa = $("#ac_item_tarifa").val();
    var duracion = $("#ac_item_duracion").val();
    
    if(isNumeric(quantity)  && isNumeric(tarifa)) {

      price = (tarifa / duracion  ) * 10; 

      var total = quantity * price;
      
      $("#ac_item_price").html(price);
      $("#ac_item_total").html(total);

    } else {
      $("#ac_item_total").html("0.00");
      $("#ac_item_price").html("0.00");
    }
  }
