# InTheZone

This is a simple gem that uses some simple tag generation helpers and some in-page javascript using [RequireJS](http://requirejs.org/), [Knockout](http://knockoutjs.com/) and [Moment.js](http://momentjs.com/) to make sure times displayed in a page are in the browser's local time zone and format.

## Installation

Add this line to your application's Gemfile:

    gem 'in_the_zone'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install in_the_zone

## Usage

Pretty simple:

```ruby
require 'in_the_zone'
InTheZone.time_tag( Time.now.utc, format: 'L', live_update: true )
```

Which will generate markup like:

```html
<span class="local-time" data-bind="localizeTime: { timestamp: 1400885511, format: 'L', live_update: true }">05/23/14</span>
```

Then if you include the JS from the gem at the path gleaned from:

```ruby
InTheZone.javascript_path # => "/Workspaces/in_the_zone/static_assets/javascripts/inthezone.js"
```

Or if you have the gem install, you can just run:
```sh
> in_the_zone_js_path
/Workspaces/in_the_zone/static_assets/javascripts/inthezone.js

# Or if you have it in your bundle:
> bundle exec in_the_zone_js_path
/Workspaces/in_the_zone/static_assets/javascripts/inthezone.js
```

Or, if you use RequireJS, you can add this to your config file:

```javascript
requirejs.config({
  paths: {
    ko: 'path/to/knockout',
    moment: 'path/to/moment',
    inthezone: 'path/to/js/file/you/got/above'
  }
});
require.config({
  paths: {
    inthezone: 'pat/to/js/file/you/got/above',
  }
```

You can of course just copy the JS file to your repo as well... whatever works!

```sh
cp `in_the_zone_js_path` ./static/javascripts
```

This span will automatically fill in with the time displayed in the correct format, in the correct timezone for the browser, as long as you have required the `inthezone` module and applied bindings.

```javascript
define('test',
  ['ko', 'moment', 'inthezone'],
  function(ko,moment,zone) {
    ko.applyBindings();
  }
);
```

# Demo
Please see the demo page at `static_assets/test.html`.

## Contributing

1. Fork it ( http://github.com/remotezygote/in_the_zone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
