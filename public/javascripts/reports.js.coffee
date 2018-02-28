$ ->
  $(document).on 'change', '#marcas_select', (evt) ->
    $.ajax 'update_marcas',
      type: 'GET'
      dataType: 'script'
      data: {
        country_id: $("#marcas_select option:selected").val()
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic marca select OK!")