$(document).ready(function(){
  flatpickr("#date_picker", {
    disableMobile: true,
    defaultDate: new Date(),
    dateFormat: "d-m-Y",
    minDate: "today",
    // "disable": [
    //   function(date) {
    //     // return true to disable
    //     return (date.getDay() === 6 || date.getDay() === 0);
    //   }
    // ],
   "locale": {
    "firstDayOfWeek": 1 // start week on Monday
    }
  });
});
