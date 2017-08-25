$(document).ready(function(){
  $("#cleaner-accepted").iziModal({
    title: 'Order accepted',
    subtitle: 'A cleaner is coming to clean your car !',
    icon: 'icon-power_settings_new',
    headerColor: '#32B796',
    width: 600,
    timeout: 3000,
    timeoutProgressbar: true,
    transitionIn: 'fadeInDown',
    transitionOut: 'fadeOutDown',
    pauseOnHover: true,
  });

  $(document).on('click', '.ladda-button', function (event) {
    event.preventDefault();
    setTimeout(function(){
      $('#cleaner-accepted').iziModal('open');
    }, 4000);
    $('.ladda-label').text('Cleaner incoming');
    var b = $(':submit');
    b.removeClass('btn-primary');
    b.addClass('btn-success').addClass('ladda-button-disabled');

    // wtf...
    $('submit').on('click', function(e) {
        e.preventDefault();
    });
  });
});
