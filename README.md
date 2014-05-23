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
<span class="local-time" data-bind="localizeTime: { timestamp: 1400869278, format: 'L', live_update: true }"></span>
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
require.config({
  paths: {
    inthezone: 'pat/to/js/file/you/got/above',
  }
```

This span will automatically fill in with the time displayed in the correct format, in the correct timezone for the browser.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/in_the_zone/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
