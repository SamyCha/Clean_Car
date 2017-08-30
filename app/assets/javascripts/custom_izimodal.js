$(document).ready(function(e){
  $("#cleaner-accepted").iziModal({
    title: 'Process to payment',
    subtitle: 'Cleaning will be booked after payment',
    icon: 'icon-power_settings_new',
    headerColor: '#32B796',
    width: 600,
    timeout: 3000,
    timeoutProgressbar: true,
    transitionIn: 'fadeInDown',
    transitionOut: 'fadeOutDown',
    pauseOnHover: true,
  });

  $('.ladda-button').on('click', function(event) {
    setTimeout(function(){
      $('#cleaner-accepted').iziModal('open');
    }, 4000);
    $('.ladda-label').text('Cleaner Validated');
    var b = $('.btn.ladda-button.progress-demo');
    b.removeClass('btn-primary');
    b.addClass('btn-success').addClass('ladda-button-disabled');
    $('.btn-cache').removeClass('hidden');
  });
});
