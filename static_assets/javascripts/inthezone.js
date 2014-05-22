define('inthezone',
	['ko', 'moment'],
	function(ko, moment) {

		var InTheZone = function(element, opts) {
			this.element = element;
			this.format = ko.observable(opts.format);
			this.current_time = ko.observable(moment.unix(opts.timestamp));
			this.from_now = ko.observable(opts.from_now);
			this.live_update = ko.observable(opts.live_update);
			if(this.live_update()) {
				this.start_interval();
			};
			var handler = this;
			element.update_time = function(new_time) { handler.update_time.apply(handler,[new_time]); };
		};

		InTheZone.prototype.start_interval = function() {
			var handler = this;
			clearTimeout(this.periodical_updater);
			this.periodical_updater = setTimeout(function() {
				handler.update_time.apply(handler);
			}, this.appropriate_interval());
		};

		var interval_base = 1000;

		InTheZone.prototype.appropriate_interval = function() {
			var diff = Math.abs(this.current_time().diff(moment.utc(),'seconds'));
			if(diff < 60) return(10*interval_base);
			if(diff < 60*60) return(60*interval_base);
			if(diff < 60*60*24) return(60*60*interval_base);
			return(60*60*24*interval_base);
		};

		InTheZone.prototype.update_time = function(new_time) {
			if(new_time) this.current_time(moment(new_time));
			if(this.from_now()) {
				this.element.innerHTML = this.current_time().fromNow();
			} else {
				this.element.innerHTML = this.current_time().format(this.format());
			};
			this.element.classList.add("localized");
			if(this.live_update()) {
				this.start_interval();
			};
		};

		ko.bindingHandlers.localizeTime = {
			init: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
				if(element.timeHandler) return;
				var allBindings = allBindingsAccessor().localizeTime;
				var time_handler = new InTheZone(element, allBindings);
				element.timeHandler = time_handler;
			},
			update: function(element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) {
				element.timeHandler.update_time();
			}
		}
});
