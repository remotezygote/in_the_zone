module LDML

  @patterns = /(y+|Y+|Q{1,4}|M{1,5}|w{1,2}|W|d{1,2}|D{1,3}|E{1,6}|e{1,6}|a|h{1,2}|H{1,2}|m{1,2}|s{1,2}|L{1,4}|l{1,4})/m;

  extend self

  def format( date, pattern )
    return date.strftime( convert_to_strftime( pattern ) )
  end

  def convert_to_strftime( pattern )
    return pattern.gsub(@patterns) do |match|
      token = match.slice( 0, 1  )
      len = match.length
      case token
      when 'y', 'Y'
        "%Y"
      when 'M'
        if (len === 1)
          "%-m"
        elsif (len < 3)
          "%m"
        elsif (len === 3)
          "%b"
        elsif (len === 4)
          "%B"
        else
          "%^b"
        end
      when 'w'
        "%U"
      when 'd'
        if (len === 1)
          "%-d"
        else
          "%d"
        end
      when 'D'
        "%j"
      when 'e', 'E'
        if ( (token == 'e') && (len < 3) )
          "%w"
        elsif (len < 4)
          "%a"
        else
          "%A"
        end
      when 'a'
        "%P"
      when 'A'
        "%p"
      when 'h'
        len > 1 ? "%I" : "%l"
      when 'H'
        len > 1 ? "%H" : "%k"
      when 'm'
        "%M"
      when 's'
        "%S"
      when 'L'
        case len
        when 1
          "%D"
        when 2
          "%B %d %Y"
        when 3
          "%B %d %Y %l:%M %p"
        else
          "%A, %B %d %Y %l:%M %p"
        end
      else # just add spaces for any unsupported formats (sucks)
        " " * len
      end
    end
  end

end
