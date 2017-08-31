//= require cable
//= require_self
//= require_tree .

App.cable.subscriptions.create('CleaningsChannel',
  {
  received: function(data) {
    console.log("ws working !");
    $('.socket-field').append(data);
  }
});
