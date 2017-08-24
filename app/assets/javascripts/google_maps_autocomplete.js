var input_to_autocomplete = $('.autocomplete').get(0);

if (input_to_autocomplete) {
  var autocomplete = new google.maps.places.Autocomplete(input_to_autocomplete, { types: ['geocode'] });
  google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
  google.maps.event.addDomListener(input_to_autocomplete, 'keydown', function(e) {
    // uncomment for testings purposes
    // if (e.keyCode == 13) {
    //   e.preventDefault();
    // }
  });
}

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  // $('#user_address').trigger('blur').val(components.address);
  $('#flat_zip_code').val(components.zip_code);
  $('#flat_city').val(components.city);
  if (components.country_code) {
    $('#flat_country').val(components.country_code);
  }

  // first result given by the API
  var firstResult = $(".pac-container .pac-item:first").text();
  // $("#user_address").val(firstResult);

  var userInput = $('.autocomplete').val();
  $('.autocomplete').attr('placeholder',userInput);
  $('.autocomplete').val(userInput);
  $('.btn').focus()
}

function getAddressComponents(place) {
  // If you want lat/lng, you can look at:
  // - place.geometry.location.lat()
  // - place.geometry.location.lng()

  var street_number = null;
  var route = null;
  var zip_code = null;
  var city = null;
  var country_code = null;
  for (var i in place.address_components) {
    var component = place.address_components[i];
    for (var j in component.types) {
      var type = component.types[j];
      if (type == 'street_number') {
        street_number = component.long_name;
      } else if (type == 'route') {
        route = component.long_name;
      } else if (type == 'postal_code') {
        zip_code = component.long_name;
      } else if (type == 'locality') {
        city = component.long_name;
      } else if (type == 'country') {
        country_code = component.short_name;
      }
    }
  }

  return {
    address: street_number == null ? route : (street_number + ' ' + route),
    zip_code: zip_code,
    city: city,
    country_code: country_code
  };
}
