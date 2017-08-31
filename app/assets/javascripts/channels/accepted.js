App.cable.subscriptions.create("AcceptedChannel",
  {
  received: function(data){
    console.log("second one working..")
    $('#pay-infos').removeClass('hidden');
    $('#cleaner-recap').html(data.message_partial);
  }
});
