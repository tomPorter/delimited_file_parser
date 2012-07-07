class DuplicateRegexPositionError < Exception
end
class DelimParser
  attr_reader :expected_length, :delimiter
  def initialize(delimiter,expected_length)
    @marker_fields = {}
    @expected_length = expected_length
    @delimiter = delimiter
  end

  def add_mask(position,regex)
    if @marker_fields.include? position
      raise DuplicateRegexPositionError, "Position #{position} already used"
    end
    @marker_fields[position] = regex
    @marker_fields.length
  end

  def is_line_ok?(split_line)
    @marker_fields.each do |position,regex|
      token = split_line.fields[position-1]
      unless token.match(/#{regex}/) 
        return false
      end
    end  
    true
  end

end

class SplitLine
  attr_accessor :fields
  def initialize(line,delim)
    @fields = line.strip.split(delim)
  end                          

  def line_right_size?(expected_size)
    @fields.length == expected_size
  end
end
