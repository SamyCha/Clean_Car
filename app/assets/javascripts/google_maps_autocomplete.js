$(document).ready(function() {
  var cleaner_address = $('#location_address').get(0);

  if (cleaner_address) {
    var autocomplete = new google.maps.places.Autocomplete(cleaner_address, { types: ['geocode'] });
    google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    google.maps.event.addDomListener(cleaner_address, 'keydown', function(e) {
      // uncomment for testing purposes
      // if (e.keyCode == 13) {
      //   e.preventDefault();
      // }
    });
  }
});

function onPlaceChanged() {
  var place = this.getPlace();
  var components = getAddressComponents(place);

  $('#location_address').trigger('blur').val(components.address);
  $('#flat_zip_code').val(components.zip_code);
  $('#flat_city').val(components.city);
  if (components.country_code) {
    $('#flat_country').val(components.country_code);
  }
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
