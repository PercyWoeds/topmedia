// Document ready (on load)
  function documentReady() {
    fixPngs();
  	tableColors();
  	textClasses();
  	dropdowns();
  }

  // Dropdowns
  function dropdowns() {
    $(".dropdown").each(function() {
      var id = $(this).attr("id");
  		var part = id.split("_");
  		part = part[1];
  		
  		var id_menu = "menu_" + part;
  		
  		var offset = $(this).offset();
  		
  		$("#" + id_menu).css({"left": (offset.left - 20) + "px", "top": (offset.top + 12) + "px"});
  		
  		$(this).click(function() {
  		  return false;
  	  });
  		
  		$(this).mouseover(function() {
  			$("#" + id_menu).css("display", "block");
  		});
  		
  		$("#" + id_menu).mouseover(function() {
  			$("#" + id_menu).css("display", "block");
  		});
  		
  		$(this).mouseout(function() {
  			$("#" + id_menu).css("display", "none");
  		});
  		
  		$("#" + id_menu).mouseout(function() {
  			$("#" + id_menu).css("display", "none");
  		});
    });
  }

  // Is Numeric support
  function isNumeric(input) {
      return (input - 0) == input && input.length > 0;
  }

  // Shows loading box
  function showLoading() {
  	$('#loading').centerInClient();
  	$('#loading').css("display", "block");
  }

  // Hides loading box
  function hideLoading() {
  	$("#loading").fadeOut("fast");
  }

  // Shows or hides aa div
  function toggle(id) {
    if($("#" + id).css("display") == "none") {
      $("#" + id).css("display", "block");
    } else {
      $("#" + id).css("display", "none");
    }
  }

  // Arregla PNGs para IE6
  function fixPngs() {
  	$('body').supersleight();
  }

  // Alterna colores de rows de una tabla
  function tableColors() {
  	$("tr:even").css("background-color", "#dddddd");
  	$("tr:odd").css("background-color", "#ffffff");
  	$("table.portada tr").css("background-color", "#ffffff");
  	
  	$("tr:even").mouseover(function() {
  		$(this).css("background-color", "yellow");
  	});
  	
  	$("tr:even").mouseout(function() {
  		$(this).css("background-color", "#dddddd");
  	});
  	
  	$("tr:odd").mouseover(function() {
  		$(this).css("background-color", "yellow");
  	});
  	
  	$("tr:odd").mouseout(function() {
  		$(this).css("background-color", "#ffffff");
  	});
  }

  // Agrega clase de text a todos los textfields
  function textClasses() {
    $('input[type=submit]').addClass('button');
    $('input[type=button]').addClass('button');
    
  	$('input[type=text]').addClass('text');
  	$('input[type=password]').addClass('text');
    
    $('.small input[type=text]').addClass('small');
    $('.small select').addClass('small');
    $('.small input[type=submit]').addClass('small');
    $('.small input[type=button]').addClass('small');
  }

  // Shows the remote window
  function showRemote() {
    $("#remote").centerInClient();
    $("#remote").css("display", "block");
    documentReady();
  }

  // Hides the remote window
  function hideRemote() {
    $("#remote").css("display", "none");
  }

  // Displays html in remote window
  function displayRemote(html) {
    html = '<div class="fright"><a href="#" onclick="hideRemote(); return false;">X</a></div>' + html + '<div class="break"><!-- i --></div>';
    $("#remote").html(html);
  }

  // Add an item to a product kit
  function addItemToKit() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#products_kit_company_id").val();
      var item_id = $("#ac_item_id").val();
      var quantity = $("#ac_item_quantity").val();
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Please enter a valid quantity");
      } else {
        if($.inArray(item_id, items_arr) == -1) {
          $("#items").val($("#items").val() + "," + item_id);
          $("#items_quantities").val($("#items_quantities").val() + "," + quantity);
          listItemsKit();
          
          $("#ac_item_id").val("");
          $("#ac_item").val("");
          $("#ac_item_quantity").val("1");
        } else {
          alert("The item already exists in the product kit.");
        }
      }
    } else {
      alert("Please find a product to add first.");
    }
  }

  // List items in a kit
  function listItemsKit() {
    var items = $("#items").val();
    var items_quantities = $("#items_quantities").val();
    var company_id = $("#products_kit_company_id").val();
    
    $.get('/products_kits/list_items/' + company_id, {
      items: items,
      items_quantities: items_quantities
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  // Removes an item from a kit
  function removeItemFromKit(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(items_arr[i] != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsKit();
  }
  

 // Update price total for invoice
  function updateItemTotal() {
    var quantity = $("#ac_item_quantity").val
    var price = $("#ac_item_price").val();
    var discount = $("#ac_item_discount").val();
    
    if(isNumeric(quantity) && isNumeric(price) && isNumeric(discount)) {
      var total = quantity * price;
      total -= total * (discount / 100);

      $("#ac_item_total").html(total);
    } else {
      $("#ac_item_total").html("0.00");
    }
  }


  // Add an item to a product kit
  function addItemToInvoice() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#invoice_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var price = $("#ac_item_price").val();
      var discount = $("#ac_item_discount").val();    
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Please enter a valid quantity");
      } else if(price == "" || !isNumeric(price)) {
        alert("Please enter a valid price");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Please enter a valid discount");
      } else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price + "|BRK|" + discount;
        
        $("#items").val($("#items").val() + "," + item_line);
        
        listItemsInvoice();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_discount").val("0");
        updateItemTotal();
      }
    } else {
      alert("Please find a product to add first.");
    }
  }

  // List items in a kit
  function listItemsInvoice() {
    var items = $("#items").val();
    var company_id = $("#invoice_company_id").val();
    
    $.get('/invoices/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  // Update price total for invoice
  function updateItemTotal2() {
    var quantity = $("#ac_item_quantity").val();
    var price = $("#ac_item_price").val();
    var discount = $("#ac_item_discount").val();
    
    if(isNumeric(quantity) && isNumeric(price) && isNumeric(discount)) {
      var total = quantity * price;
      total -= total * (discount / 100);

      $("#ac_item_total").html(total);
    } else {
      $("#ac_item_total").html("0.00");
    }
  }

  // Add an item to a product kit
  function addItemToInvoice2() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#factura_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var price = $("#ac_item_price").val();
      var discount = $("#ac_item_discount").val();
      
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Please enter a valid quantity");
      } else if(price == "" || !isNumeric(price)) {
        alert("Please enter a valid price");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Please enter a valid discount");
      } else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price + "|BRK|" + discount;
        
        $("#items").val($("#items").val() + "," + item_line);
        listItemsInvoice2();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_discount").val("0");
        updateItemTotal2();
      }
    } else {
      alert("Please find a product to add first.");
    }
  }

  // List items in a kit
  function listItemsInvoice2() {
    var items = $("#items").val();
    var company_id = $("#factura_company_id").val();
    
    $.get('/facturas/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }


  // Update price total for invoice
  function updateItemdelivery() {
    var quantity = $("#ac_item_quantity").val();
    var price = $("#ac_item_price").val();
    var discount = $("#ac_item_discount").val();
    
    if(isNumeric(quantity) && isNumeric(price) && isNumeric(discount)) {
      var total = quantity * price;
      total -= total * (discount / 100);

      $("#ac_item_total").html(total);
    } else {
      $("#ac_item_total").html("$0.00");
    }
  }

  // Add an item to a product kit
  function addItemTodelivery() {
    var item = $("#ac_item_id").val();

   if(item != "") {
      var company_id = $("#delivery_company_id").val();
      var item_id = $("#ac_item_id").val();
          
      var quantity = $("#ac_item_quantity").val();
      var price    = $("#ac_item_price").val();    
      var discount = $("#ac_item_discount").val();
      var unidad   = $("#ac_item_unidad").val();
      var peso     = $("#ac_item_peso").val();

      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Please enter a valid quantity");
      } else if(price == "" || !isNumeric(price)) {
        alert("Please enter a valid price");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Please enter a valid discount");
      } else if(peso == "" || !isNumeric(peso)) {
        alert("Please enter a valid discount");
      } else {


    var item_line = item_id + "|BRK|" + quantity + "|BRK|" + unidad+"|BRK|" + peso+"|BRK|" + price + "|BRK|" + discount;
        
        $("#items").val($("#items").val() + "," + item_line);

        listItemsdelivery();
        

        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_discount").val("0");
        $("#ac_item2").val("");
        $("#ac_item_peso").val("0");
        updateItemdelivery();
        
      }
    } else {
      alert("Por favor primero ingrese un servicio .");
    }
  }

  // List items in a kit
  function listItemsdelivery() {
    var items = $("#items").val();
    var company_id = $("#delivery_company_id").val();
    
    $.get('/deliveries/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  // Add an item to a product kit
  function addItemTodelivery2() {
    var item = $("#ac_item3").val();
    
   if(item != "") {
      var company_id = $("#factura_company_id").val();
      var item_id = $("#ac_item_guia").val();        
      var items_arr = $("#items2").val().split(",");
      var item_line = item_id + "|BRK|" ;
        
        $("#items2").val($("#items2").val() + "," + item_line );

        listItemsdelivery2();
        
        $("#ac_item_guia").val("");
        $("#ac_item3").val("");      
      
    } else {
      alert("Please find a guia  to add first.");
    }
  }


  function listItemsdelivery2() {
    var items2 = $("#items2").val();
    var company_id = $("#factura_company_id").val();
    
    $.get('/facturas/list_items2/' + company_id, {
      items2: items2
    },
    function(data) {
      $("#list_items2").html(data);
      documentReady();
    });
  }



  // Add an item to orden de servicio 
  function addItemToOrden1() {
    var item = $("#ac_item3").val();
    
   if(item != "") {
      var company_id = $("#purchase_company_id").val();
      var item_id = $("#ac_item_os").val();        
      var items_arr = $("#items2").val().split(",");
      var item_line = item_id + "|BRK|" ;
        
        $("#items2").val($("#items2").val() + "," + item_line );

        listItemsOrden1();
        
        $("#ac_item_os").val("");
        $("#ac_item3").val("");      
      
    } else {
      alert("Por favor añadir Orden ");
    }
  }

  function listItemsOrden1() {
    var items2 = $("#items2").val();
    var company_id = $("#factura_company_id").val();
    
    $.get('/facturas/list_items2/' + company_id, {
      items2: items2
    },
    function(data) {
      $("#list_items2").html(data);
      documentReady();
    });
  }
  // Removes an item from an invoice
  function removeItemFromOrden1(id) {
    var items = $("#items2").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items2").val(items_final.join(","));
    listItemsOrden1();
  }

  // Removes an item from a kit
  function removeItemFromKit(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(items_arr[i] != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsKit();
  }

  // Removes an item from an invoice
  function removeItemFromInvoice(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsInvoice();
  }
  // Removes an item from an invoice
  function removeItemFromInvoice2(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsInvoice2();
  }
  // Removes an item from an invoice
  function removeItemFromdelivery(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsdelivery();
  }
  // Removes an item from an invoice
  function removeItemFromdelivery2(id) {
    var items = $("#items2").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items2").val(items_final.join(","));
    listItemsdelivery2();
  }

  // Removes an item from an invoice
  function removeItemFromPurchaseorder(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemspurchaseorder();
  }
  // Removes an item from an purchase
  function removeItemFromPurchase(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsPurchase();
  }

  // Shortcut to create new customer form
  function createCustomerInvoice() {
    var company_id = $("#invoice_company_id").val();
    
    $.get('/customers/new/' + company_id + '?ajax=1', {
    },
    function(data) {
      displayRemote(data);
      showRemote();
      
      $("#new_customer").bind("submit", function() {
        event.preventDefault();
        doCreateCustomerInvoice();
      });
    });
  }

  // Create new customer in the invoice via ajax
  function doCreateCustomerInvoice() {
    var company_id = $("#invoice_company_id").val();
    var name = $("#customer_name").val();
    var email = $("#customer_email").val();
    var account = $("#customer_account").val();
    var phone1 = $("#customer_phone1").val();
    var phone2 = $("#customer_phone2").val();
    var address1 = $("#customer_address1").val();
    var address2 = $("#customer_address2").val();
    var city = $("#customer_city").val();
    var state = $("#customer_state").val();
    var zip = $("#customer_zip").val();
    var country = $("#customer_country").val();
    var comments = $("#customer_comments").val();
    
    if($("#customer_taxable").attr("checked")) {
      var taxable = 1;
    } else {
      var taxable = 0;
    }
    
    if(name != "") {
      $.post('/customers/create_ajax/' + company_id, {
        name: name,
        email: email,
        account: account,
        phone1: phone1,
        phone2: phone2,
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zip: zip,
        country: country,
        comments: comments,
        taxable: taxable
      },
      function(data) {
        if(data == "error_empty") {
          alert("Please enter a customer name");
        } else if(data == "error") {
          alert("Something went wrong when saving the customer, please try again");
        } else {
          var data_arr = data.split("|BRK|");
          
          $("#ac_customer").val(data_arr[1]);
          $("#ac_customer_id").val(data_arr[0]);
          $("#selected_customer").html(data_arr[1]);
          
          hideRemote();
          alert("The customer has been created");
        }
      });
    } else {
      alert("Please enter a customer name.");
    }
  }

  // Add product kit to invoice
  function addKitToInvoice() {
    var kit = $("#ac_kit").val();
    
    if(kit != "") {
      var company_id = $("#invoice_company_id").val();
      var kit_id = $("#ac_kit_id").val();
      var discount = $("#ac_kit_discount").val();
      
      var items_arr = $("#items").val().split(",");
      
      if(discount == "" || !isNumeric(discount)) {
        alert("Please enter a valid discount");
      } else {
        $.post('/invoice/add_kit/' + company_id, {
            kit_id: kit_id,
            items: $("#items").val(),
            discount: discount
          },
          function(data) {
            if(data == "no_kit") {
              alert("We couldn't find the product kit you were looking for.");
            } else {
              $("#items").val($("#items").val() + "," + data);
              listItemsInvoice();
            }

            $("#ac_kit_id").val("");
            $("#ac_kit").val("");
          }
        );
      }
    } else {
      alert("Please find a product to add first.");
    }
  }



  // Add an item to a product kit
  function addItemToserviceorder() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#serviceorder_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var price = $("#ac_item_price").val();
      var discount = $("#ac_item_discount").val();    
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Por favor ingrese una cantidad validad");
      } else if(price == "" || !isNumeric(price)) {
        alert("Por favor ingrese un precio valido");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Por favor ingrese un descuento valido");
      } else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price + "|BRK|" + discount;
        
        $("#items").val($("#items").val() + "," + item_line);
        listItemsserviceorder();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_discount").val("0");
        updateItemTotal4();
      }
    } else {
      alert("Por favor ingrese un servicio primero.");    
    }
  }

  // List items in a kit
  function listItemsserviceorder() {
    var items = $("#items").val();
    var company_id = $("#serviceorder_company_id").val();
    
    $.get('/serviceorders/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }


  // Update price total for invoice
  function updateItemTotal5() {
    var quantity = $("#ac_item_quantity").val();
    var price = $("#ac_item_price").val();
    var discount = $("#ac_item_discount").val();
    
    if(isNumeric(quantity) && isNumeric(price) && isNumeric(discount)) {

      var total = quantity * price;
      total -= total * (discount / 100);

      $("#ac_item_total").html( total);
    } else {
      $("#ac_item_total").html("0.00");
    }
  }
  // Removes an item from an invoice
  function removeItemFromserviceorder(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsserviceorder();
  }



  // Add an item to a purchase order
          
  function addItemTopurchaseorder() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#purchaseorder_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var price = $("#ac_item_price").val();
      var discount = $("#ac_item_discount").val();    
      var items_arr = $("#items").val().split(",");
        
      if(quantity == "" || !isNumeric(quantity)) {
        alert("Por favor ingrese una cantidad validad");
      } else if(price == "" || !isNumeric(price)) {
        alert("Por favor ingrese un precio valido");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Por favor ingrese un descuento valido");
      } else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price + "|BRK|" + discount;
        
        $("#items").val($("#items").val() + "," + item_line);
        listItemspurchaseorder();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_discount").val("0");
        updateItemTotal5();
      }
    } else {
      alert("Por favor ingrese un servicio primero.");
    }
  }

  function addItemToPurchase() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#purchase_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var inafecto = $("#ac_item_inafecto").val();
      var impuesto = $("#ac_item_impuesto").val();
      var price = $("#ac_item_price").val();
      var discount = $("#ac_item_discount").val();    
      var items_arr = $("#items").val().split(",");
        
      if(quantity == "" || !isNumeric(quantity)) {
        alert("Por favor ingrese una cantidad validad");
      } else if(price == "" || !isNumeric(price)) {
        alert("Por favor ingrese un importe afecto");
      } else if(discount == "" || !isNumeric(discount)) {
        alert("Por favor ingrese un descuento valido");
      } else if(inafecto == "" || !isNumeric(inafecto)) {
        alert("Por favor ingrese un importe inafecto");
      }
      else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price + "|BRK|" + discount+"|BRK|" + inafecto+"|BRK|" + impuesto;
        
        $("#items").val($("#items").val() + "," + item_line);
        listItemsPurchase();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("0");
        $("#ac_item_inafecto").val("0");
        $("#ac_item_discount").val("0");
        $("#ac_item_impuesto").val("18");
        updateItemTotalPur();
      }
    } else {
      alert("Por favor ingrese un detalle primero.");
    }
  }


// Update price total for invoice
  function updateItemTotalPur() {

    var impuesto  = $("#ac_item_impuesto").val();
    var inafecto  = $("#ac_item_inafecto").val();
    var afecto  = $("#ac_item_price").val();
    total = 0 ;
    total1 = 0 ;

    if(isNumeric(impuesto) && isNumeric(inafecto) && isNumeric(afecto)) {

      var total1 = Number(afecto) * (1 + (Number(impuesto) / 100) )
      
      var tax      = total1 - afecto
      
      var total = Number(total1) + Number(inafecto)
      
      
      $("#ac_item_subtotal").html(total1);
      $("#ac_item_tax").html(tax);
      $("#ac_item_total").html(total);

    } else {
      
      $("#ac_item_subtotal").html("0.00");
      $("#ac_item_tax").html("0.00");
      $("#ac_item_total").html("0.00");
    }
  }  
  

  // List items in a kit
  function listItemsPurchase() {
    var items = $("#items").val();
    var company_id = $("#purchase_company_id").val();
    
    $.get('/purchases/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }


  // List items in a kit
  function listItemspurchaseorder() {
    var items = $("#items").val();
    var company_id = $("#purchaseorder_company_id").val();
    
    $.get('/purchaseorders/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  // Add an item to a product kit
  function addItemToMovement() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#movement_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Por favor una cantidad ");
      } else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|";
        
        $("#items").val($("#items").val() + "," + item_line);
        listItemsMovement();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        
        updateItemTotalMov();
      }
    } else {
      alert("Please find a product to add first.");
    }
  }

  // List items in a kit
  function listItemsMovement() {
    var items = $("#items").val();
    var company_id = $("#movement_company_id").val();
    
    $.get('/movements/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  // Update price total for invoice
  function updateItemTotalMov() {
    var quantity = $("#ac_item_quantity").val();
    var price = $("#ac_item_price").val();
    var discount = $("#ac_item_discount").val();
    
    if(isNumeric(quantity) && isNumeric(price) && isNumeric(discount)) {
      var total = quantity * price;
      total -= total * (discount / 100);

      $("#ac_item_total").html("$" + total);
    } else {
      $("#ac_item_total").html("$0.00");
    }
  }
  // Removes an item from an invoice
  function removeItemFromMovement(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsMovement();
  }

  // Add an item to a 
  function addItemToSupplierPayment() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#supplier_payment_company_id").val();

      var importe_cheque = $("#supplier_payment_total").val();
      var item_total = 0
      var item_id = $("#ac_item_id").val();      
      var price = $("#ac_item_total").val();   

      var items_arr = $("#items").val().split(",");

      if (price == "" || !isNumeric(price)) {
        alert("Por favor ingrese un precio valido  ");
      } 
      else if (importe_cheque == "" || !isNumeric(importe_cheque)) {
        alert("Por favor ingrese importe valido  ");
      }
      else {
        var item_line = item_id + "|BRK|" + price + "|BRK|";
        
        $("#items").val($("#items").val() + "," + item_line);
        
        listItemsSupplierPayment();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_total").val("");
    
        updateItemTotal6();
      }
    } else {
      alert("Por favor ingrese un documento.");
    }
  }


  // Update price total for invoice
  function updateItemTotal6() {
    
    var price = $("#ac_item_total").val();

    if( isNumeric(price)) {
      var total =  price *1;
      
      $("#ac_item_total").html(total);
      
    } else {
      
      $("#ac_item_total").html("0.00");
    }

  }


  // List items in a kit
  function listItemsSupplierPayment() {
    var items = $("#items").val();
    var company_id = $("#supplier_payment_company_id").val();
    
    $.get('/supplier_payments/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }


  function removeItemFromSupplierPayment(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    

    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsSupplierPayment();
  }

// agregar item guias  
  function addItemToGuias() {

    alert("Buscando... ");
    var item = $("#ac_item").val();
    var company_id = $("#delivery_company_id").val();

    if(item != "") {
      var company_id = $("#delivery_company_id").val();
      var item_guia = $("#ac_item_guia").val();      
      var items_arr = $("#items").val().split(",");

      if (item_guia == "" ) {
        alert("Por favor ingrese una documento valido  ");
      }     
      else {
        var item_line = item_guia + "|BRK|";        
        $("#items").val($("#items").val() + "," + item_line);        
        listItemsGuias();        
        $("#ac_item_guia").val("");
        $("#ac_item").val("");          
      }
    } else {
      alert("Por favor ingrese un documento.");
    }
  }

  // List items in a kit
  function listItemsGuias() {
    var items = $("#items").val();
    
    $.get('/deliveries/list_items2/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items2").html(data);
      documentReady();
    });
  }


  function removeItemFromGuias(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    

    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsGuias();
  }

  //............................................................................
  // agrega items customer payments
  //............................................................................

  function addItemToCustomerPayment() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#customer_payment_company_id").val();

      var importe_cheque = $("#customer_payment_total").val();
      var item_total = 0
      var item_id = $("#ac_item_id").val();      
      var factory = $("#ac_item_factory").val();      
      var compen = $("#ac_item_compen").val();      
      var ajuste = $("#ac_item_ajuste").val(); 

      var price = $("#ac_item_total").val();   
      var items_arr = $("#items").val().split(",");

      if(factory == "" || !isNumeric(factory)) {
        alert("Por favor ingrese una cantidad validad");
      }
      else if  (compen == "" || !isNumeric(compen)) {
        alert("Por favor ingrese una compensacion valida  ");
      }      
      else if  (price == "" || !isNumeric(price)) {
        alert("Por favor ingrese un precio valido  ");
      } 
      else if  (ajuste == "" || !isNumeric(ajuste)) {
        alert("Por favor ingrese un importe de ajuste valido  ");
      }       
      else {
        var item_line = item_id + "|BRK|" + compen  + "|BRK|" + ajuste + "|BRK|"+ factory + "|BRK|"+ price + "|BRK|";
        
        $("#items").val($("#items").val() + "," + item_line);
        
        listItemsCustomerPayment();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_total").val("");
        $("#ac_item_factory").val("");
        $("#ac_item_ajuste").val("");
        $("#ac_item_compen").val("");

        updateItemTotalCP();
      }
    } else {
      alert("Por favor ingrese un documento.");
    }
  }


  // Update price total for invoice
  function updateItemTotalCP() {
    var saldooriginal = $("#ac_item_total").val();

    var price     = $("#ac_item_total").val();

    var factory  = $("#ac_item_factory").val();

    var ajuste   = $("#ac_item_ajuste").val();

    var compen   = $("#ac_item_compen").val();

    $("#ac_item_total2").html(saldooriginal);

    if( isNumeric(price) && isNumeric(factory) && isNumeric(ajuste) && isNumeric(saldooriginal) && isNumeric(compen))  {
      
      var total = price+factory + ajuste ;

    } else {

    $("#ac_item_total2").html(saldooriginal);
            
    }

  }

  // List items in a kit
  function listItemsCustomerPayment() {
    var items = $("#items").val();
    var company_id = $("#customer_payment_company_id").val();
    
    $.get('/customer_payments/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }


  function removeItemFromCustomerPayment(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
  
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsCustomerPayment();
  }

 //............................................................................  

  // Add an item to a product kit
  function addItemToOutput() {
    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#output_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var quantity = $("#ac_item_quantity").val();
      var price = $("#ac_item_price").val();
      var stock = $("#ac_item_stock").val();
    
      var items_arr = $("#items").val().split(",");

      if(quantity == "" || !isNumeric(quantity)) {
        alert("Por favor ingrese una cantidad valida");
      }  else if( Number(quantity) > Number(stock) ) {
        alert("Por favor ingrese una cantidad igual o menor al stock ");
      }  else {
        var item_line = item_id + "|BRK|" + quantity + "|BRK|" + price ;
        
        $("#items").val($("#items").val() + "," + item_line);
        
        listItemsOutput();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_quantity").val("1");
        $("#ac_item_price").val("");
        $("#ac_item_stock").val("");
      
        updateItemTotalOutput();
      }
    } else {
      alert("Por favor agregue un item .");
    }
  }

  // List items in a kit
  function listItemsOutput() {
    var items = $("#items").val();
    var company_id = $("#output_company_id").val();
    
    $.get('/outputs/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

// Update price total for invoice
  function updateItemTotalOutput() {
    var quantity = $("#ac_item_quantity").val();
    var price = $("#ac_item_price").val();
    
    
    if(isNumeric(quantity) && isNumeric(price)) {
      var total = quantity * price;      

      $("#ac_item_total").html(total);
    } else {
      $("#ac_item_total").html("0.00");
    }
  }

// Removes an item from an invoice
  function removeItemFromOutput(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsOutput();
  }



// Add an item to Orden
  function addItemToOrden() { 

    var item = $("#ac_item").val();
    
    if(item != "") {
      var company_id = $("#orden_company_id").val();
      var item_id = $("#ac_item_id").val();
      
      var price  = $("#ac_item_price").val();
      var tarifa = $("#ac_item_tarifa").val();
      var total  = $("#ac_item_total").val();
      
      var item_1 =  $("#ac_item_1").val();
      var item_2 =  $("#ac_item_2").val();
      var item_3 =  $("#ac_item_3").val();    
      var item_4 =  $("#ac_item_4").val();
      var item_5 =  $("#ac_item_5").val();
      var item_6 =  $("#ac_item_6").val();
      var item_7 =  $("#ac_item_7").val();
      var item_8 =  $("#ac_item_8").val();
      var item_9 =  $("#ac_item_9").val();    
      var item_10 =  $("#ac_item_10").val();
      var item_11 =  $("#ac_item_11").val();
      var item_12 =  $("#ac_item_12").val();
      var item_13 =  $("#ac_item_13").val();
      var item_14 =  $("#ac_item_14").val();
      var item_15 =  $("#ac_item_15").val();    
      var item_16 =  $("#ac_item_16").val();
      var item_17 =  $("#ac_item_17").val();
      var item_18 =  $("#ac_item_18").val();
      var item_19 =  $("#ac_item_19").val();
      var item_20 =  $("#ac_item_20").val();
      var item_21 =  $("#ac_item_21").val();    
      var item_22 =  $("#ac_item_22").val();
      var item_23 =  $("#ac_item_23").val();
      var item_24 =  $("#ac_item_24").val();
      var item_25 =  $("#ac_item_25").val();    
      var item_26 =  $("#ac_item_26").val();
      var item_27 =  $("#ac_item_27").val();
      var item_28 =  $("#ac_item_28").val();
      var item_29 =  $("#ac_item_29").val();
      var item_30 =  $("#ac_item_30").val();
      var item_31 =  $("#ac_item_31").val();
      
      
    
    
      var items_arr = $("#items").val().split(",");

      if(tarifa == "" || !isNumeric(tarifa)) {
        alert("Por favor ingrese una cantidad valida");
    
      }  else {
        
        var item_line = item_id+"|BRK|" +item_1+"|BRK|"+item_2 +"|BRK|"+item_3+"|BRK|"+item_4+"|BRK|"+item_5+"|BRK|"+item_6+"|BRK|"+item_7+"|BRK|"+item_8+"|BRK|"+item_9+"|BRK|"+item_10+"|BRK|"+item_11+"|BRK|"+item_12 +"|BRK|"+item_13+"|BRK|"+item_14+"|BRK|"+item_15+"|BRK|"+item_16+"|BRK|"+item_17+"|BRK|"+item_18+"|BRK|"+item_19+"|BRK|"+item_20+"|BRK|"+item_21+"|BRK|"+item_22+"|BRK|"+item_23+"|BRK|"+item_24+"|BRK|"+item_25+"|BRK|"+item_26+"|BRK|"+item_27+"|BRK|"+item_28+"|BRK|"+item_29+"|BRK|"+item_30+"|BRK|"+item_31+"|BRK|"+ price + "|BRK|" + tarifa + "|BRK|" + total ;
        
        $("#items").val($("#items").val() + "," + item_line);
        
        listItemsOrden();
        
        $("#ac_item_id").val("");
        $("#ac_item").val("");
        $("#ac_item_tarifa").val("0");
        $("#ac_item_price").val("");
        $("#ac_item_total").val("");
        
        $("#ac_item_1").val("0");
        $("#ac_item_2").val("0");
        $("#ac_item_3").val("0");
        $("#ac_item_4").val("0");
        $("#ac_item_5").val("0");
        $("#ac_item_6").val("0");
        $("#ac_item_7").val("0");
        $("#ac_item_8").val("0");
        $("#ac_item_9").val("0");
        $("#ac_item_10").val("0");
        $("#ac_item_11").val("0");
        $("#ac_item_12").val("0");
        $("#ac_item_13").val("0");
        $("#ac_item_14").val("0");
        $("#ac_item_15").val("0");
        $("#ac_item_16").val("0");
        $("#ac_item_17").val("0");
        $("#ac_item_18").val("0");
        $("#ac_item_19").val("0");
        $("#ac_item_20").val("0");
        $("#ac_item_21").val("0");
        $("#ac_item_22").val("0");
        $("#ac_item_23").val("0");
        $("#ac_item_24").val("0");
        $("#ac_item_25").val("0");
        $("#ac_item_26").val("0");
        $("#ac_item_27").val("0");
        $("#ac_item_28").val("0");
        $("#ac_item_29").val("0");
        $("#ac_item_30").val("0");
        $("#ac_item_31").val("0");
        $("#ac_item_total").val("0");
      
      }
    } else {
      alert("Por favor agregue un item .");
    }
  }
  function updateItemOrden() {
    
    var tarifa   = $("#orden_product_tarifa").val();
    var duracion = $("#ac_item_duracion").val();  
    
    
      var item_1  =  $("#orden_product_d01").val();
      var item_2  =  $("#orden_product_d02").val();
      var item_3  =  $("#orden_product_d03").val();    
      var item_4  =  $("#orden_product_d04").val();
      var item_5  =  $("#orden_product_d05").val();
      var item_6  =  $("#orden_product_d06").val();
      var item_7  =  $("#orden_product_d07").val();
      var item_8  =  $("#orden_product_d08").val();
      var item_9  =  $("#orden_product_d09").val();    
      var item_10 =  $("#orden_product_d10").val();
      var item_11 =  $("#orden_product_d11").val();
      var item_12 =  $("#orden_product_d12").val();
      var item_13 =  $("#orden_product_d13").val();
      var item_14 =  $("#orden_product_d14").val();
      var item_15 =  $("#orden_product_d15").val();    
      var item_16 =  $("#orden_product_d16").val();
      var item_17 =  $("#orden_product_d17").val();
      var item_18 =  $("#orden_product_d18").val();
      var item_19 =  $("#orden_product_d19").val();
      var item_20 =  $("#orden_product_d20").val();
      var item_21 =  $("#orden_product_d21").val();    
      var item_22 =  $("#orden_product_d22").val();
      var item_23 =  $("#orden_product_d23").val();
      var item_24 =  $("#orden_product_d24").val();
      var item_25 =  $("#orden_product_d25").val();    
      var item_26 =  $("#orden_product_d26").val();
      var item_27 =  $("#orden_product_d27").val();
      var item_28 =  $("#orden_product_d28").val();
      var item_29 =  $("#orden_product_d29").val();
      var item_30 =  $("#orden_product_d30").val();
      var item_31 =  $("#orden_product_d31").val();
      
    if( isNumeric(tarifa) || isNumeric(duracion)) {
    
      var price = ((tarifa) / 30 * parseInt(duracion ));
      
      var suma_dias =parseInt(item_1)+parseInt(item_2)+parseInt(item_3)+parseInt(item_4)+ parseInt(item_5)+parseInt(item_6)+parseInt(item_7)+parseInt(item_8)+parseInt(item_9)+parseInt(item_10)+
                     parseInt(item_11)+parseInt(item_12)+parseInt(item_13)+parseInt(item_14)+ parseInt(item_15)+parseInt(item_16)+parseInt(item_17)+parseInt(item_18)+parseInt(item_19)+parseInt(item_20)+
                     parseInt(item_21)+parseInt(item_22)+parseInt(item_23)+parseInt(item_24)+ parseInt(item_25)+parseInt(item_26)+parseInt(item_27)+parseInt(item_28)+parseInt(item_29)+parseInt(item_30)+parseInt(item_31);
      var total =  suma_dias * parseFloat(price);
      
      $("#orden_product_quantity").html(suma_dias);
      $("#orden_product_price").html(price);
      $("#orden_product_total").html(total);
      
      document.getElementById('orden_product_quantity').value = suma_dias;
      document.getElementById('orden_product_price').value = price;
      document.getElementById('orden_product_total').value = total;

    } else {
      
      $("#orden_product_price").html("0.00");
      $("#orden_product_total").html("0.00");
      
    }
  }

 function updateItemContrato() {
      
      var c_importe   = $("#quote_importe").val();
      var c_comision1 = $("#ac_item_comision1").val();
      var c_comision2 = $("#ac_item_comision2").val();
   
   
      var vventa  =  ((c_importe) / 1.18 );
      var comision1  =  vventa * parseFloat(c_comision1)/100;
      var comision2  =  vventa * parseFloat(c_comision2)/100 ;
      var totalcomision = comision1 + comision2 ;
   

     
      
      document.getElementById('quote_vventa').value = vventa.toFixed(2);
      document.getElementById('quote_comision1').value = comision1.toFixed(2);
      document.getElementById('quote_comision2').value = comision2.toFixed(2);
      document.getElementById('quote_total').value = totalcomision.toFixed(2);
      
 
  }


  // List items in a kit
  function listItemsOrden() {
    var items = $("#items").val();
    var company_id = $("#orden_company_id").val();
    
    $.get('/ordens/list_items/' + company_id, {
      items: items
    },
    function(data) {
      $("#list_items").html(data);
      documentReady();
    });
  }

  
// Removes an item from an invoice
  function removeItemFromOrden(id) {
    var items = $("#items").val();
    var items_arr = items.split(",");
    var items_final = Array();
    var i = 0;
    
    while(i < items_arr.length) {
      if(i != id) {
        items_final[i] = items_arr[i];
      }
      i++;
    }
    
    $("#items").val(items_final.join(","));
    listItemsOrden();
  }


function getFormattedDate(date) {
  var year = date.getFullYear();
  var month = (1 + date.getMonth()).toString();
  month = month.length > 1 ? month : '0' + month;
  var day = date.getDate().toString();
  day = day.length > 1 ? day : '0' + day;
  return month + '/' + day + '/' + year;
}

 //............................................................................  


  // On ready
  $(document).ready(function() {
    documentReady();
    
    $("#loading")
      .hide()
      .ajaxStart(function() {
        showLoading();
      })
      .ajaxStop(function() {
        hideLoading();
      })
    ;
  });
