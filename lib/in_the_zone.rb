require 'in_the_zone/version'
require 'erubis'
require 'pathname'

module InTheZone

  extend self

  DefaultOptions = { classes: "local-time", format: "%a, %d %b %Y %T" }.freeze
  TagTemplate = "<span class=\"<%= classes %>\" data-bind=\"localizeTime: { timestamp: <%= timestamp %>, format: '<%= time_format %>' }\"><%= time_string %></span>".freeze

  def time_tag( time=Time.now.utc, opts={} )
    tag_data = normalize_opts( opts )
    tag_template.result( tag_data.merge( time_string: time_string( time.utc, tag_data[ :format ] ), time_format: tag_data[ :format ], timestamp: time.utc.to_i ) )
  end

  def date_tag( date, opts={} )
    time_tag( date.to_time, opts.merge( date_only: true, format: "%a, %d %b %Y" ) )
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
    time.strftime( fmt )
  end

  def normalize_opts( opts )
    data = DefaultOptions.dup
    data[ :classes ] = [ data[ :classes ] ]
    if opts[ :date_only ]
      data[ :classes ].push "date_only"
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
