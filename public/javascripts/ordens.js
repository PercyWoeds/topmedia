jQuery(function() {
  var states;
  states = $('#orden_version_id').html();
  console.log(states);
  return $('#orden_marca_id').change(function() {
    var country, options;
    country = $('#orden_marca_id :selected').text();
    options = $(states).filter("optgroup[label=" + country + "]").html();
    console.log(options);
    if (options) {
      return $('#orden_version_id').html(options);
    } else {
      return $('#orden_version_id').empty();
    }
  });
});