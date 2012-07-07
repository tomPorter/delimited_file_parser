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
end

class SplitLine
  attr_accessor :fields
  def initialize(line,delim)
    @fields = line.split(delim)
  end                          

  def line_right_size?(expected_size)
    @fields.length == expected_size
  end
end
