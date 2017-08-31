App.cable.subscriptions.create("AcceptedChannel",
  {
  received: function(data){
    console.log("second one working..")
    $('.accepted').append("<p class='col-xs-12 btn btn-primary'>A cleaner is coming</p>");
  }
});
