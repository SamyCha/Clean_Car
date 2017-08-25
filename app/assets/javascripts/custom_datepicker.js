$(document).ready(function(){
  flatpickr("#date_picker", {
    disableMobile: true,
    defaultDate: new Date(),
    dateFormat: "d-m-Y",
  });
  // different syntax $("#date_picker").flatpickr({disableMobile: true});
});
