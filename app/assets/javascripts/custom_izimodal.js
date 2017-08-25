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
      pauseOnHover: true
  });
  $(document).on('click', '.trigger', function (event) {
      event.preventDefault();
      $('#cleaner-accepted').iziModal('open');
  });
});
