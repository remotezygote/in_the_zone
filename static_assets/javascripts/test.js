requirejs.config({
  paths: {
    ko: 'knockout-min-3.1.0',
    moment: 'moment-min-2.6.0'
  }
});
define('test',
  ['ko', 'moment', 'inthezone'],
  function(ko,moment,zone) {
    ko.applyBindings();
    document.querySelector("#live").timeHandler.update_time(new Date());
    var d = new Date();
    d.setDate(d.getDate() - 1);
    document.querySelector("#live-yesterday").timeHandler.update_time(d);
  }
);
