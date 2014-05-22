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
  }
);
