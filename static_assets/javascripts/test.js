requirejs.config({
  paths: {
    ko: 'knockout-min-3.1.0',
    moment: 'moment-min-2.6.0',
    inthezone: 'in_the_zone'
  }
});
define('test',
  ['ko', 'moment', 'inthezone'],
  function(ko,moment,zone) {
    ko.applyBindings();
    var lives = document.querySelectorAll(".live")
    for(i=0;i<lives.length;i++) lives[i].timeHandler.update_time(new Date());
    var d = new Date();
    d.setDate(d.getDate() - 1);
    document.querySelector("#live-yesterday").timeHandler.update_time(d);
  }
);
