require 'in_the_zone/version'
require 'in_the_zone/ldml_format'
require 'erubis'
require 'pathname'

module InTheZone

  extend self

  DefaultOptions = { format: "LLL" }.freeze
  TagTemplate = "<span class=\"<%= classes %>\" data-bind=\"localizeTime: { timestamp: <%= timestamp %>, format: '<%= time_format %>'<%= options %> }\"><%= time_string %></span>".freeze

  def time_tag( time=Time.now.utc, opts={} )
    tag_data = normalize_opts( opts )
    options = tag_data[ :options ].inject([""]) do |acc, (k,v)|
      acc << "#{k}: #{ v.is_a?(String) ? "'#{v}'" : v.to_s }"
      acc
    end.join(", ")
    tag_template.result( tag_data.merge( time_string: time_string( time.utc, tag_data[ :format ] ), time_format: tag_data[ :format ], timestamp: time.utc.to_i, options: options ) )
  end

  def date_tag( date, opts={} )
    opts[ :format ] ||= 'LL'
    opts[ :date_only ] = true
    time_tag( date.to_time, opts )
  end

  def javascript_path
    @javascript_path ||= File.join( gem_asset_path, "javascripts", "inthezone.js" )
  end

  def stylesheet_path
    @stylesheet_path ||= File.join( gem_asset_path, "stylesheets", "inthezone.css" )
  end

  def set_tag_template( new_template )
    @tag_template = Erubis::Eruby.new( new_template )
  end
  alias_method :tag_template=, :set_tag_template

  private

  def tag_template
    @tag_template ||= Erubis::Eruby.new( TagTemplate.dup )
  end

  def time_string( time, fmt )
    LDML.format( time, fmt )
  end

  def normalize_opts( opts )
    data = DefaultOptions.dup
    data[ :classes ] = [ 'local-time' ]
    data[ :options ] = {}
    if opts[ :from_now ]
      data[ :options ][ :from_now ] = true
    end
    if opts[ :live_update ]
      data[ :options ][ :live_update ] = true
    end
    if opts[ :format ]
      data[ :format ] = opts[ :format ]
    end
    data[ :classes ] = data[ :classes ].sort.join(" ")
    data
  end

  def gem_asset_path
    @gem_asset_path ||= File.expand_path( File.join( Pathname(__FILE__).dirname, "/../static_assets/" ) )
  end

end
