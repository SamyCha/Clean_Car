$('.dropdown-toggle').dropdown()

$(document).ready(function(){
  setTimeout(function(){
    $('#flash').css('-webkit-animation', 'fadeOut 500ms');
    $('#flash').remove();
  }, 4000);
 })
