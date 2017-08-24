$(document).ready(function(){
  $('.dropdown-toggle').dropdown()

  setTimeout(function(){
    $('#flash').css('animation', 'fadeOut 500ms');
    $('#flash').remove();
  }, 4000);
  $('#dropdown-toggle').dropdown();
 })
