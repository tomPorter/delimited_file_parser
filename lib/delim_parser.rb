require 'csv'
class RegexPositionOutOfBoundsError < Exception
end
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
    unless  (1..@expected_length).include? position
      raise RegexPositionOutOfBoundsError, "Position #{position} not between 1 and #{@expected_length}"
    end
    if @marker_fields.include? position
      raise DuplicateRegexPositionError, "Position #{position} already used"
    end
    @marker_fields[position] = regex
    @marker_fields.length
  end

  def is_line_ok?(split_line)
    return false if @expected_length != split_line.fields.length
    @marker_fields.each do |position,regex|
      token = split_line.fields[position-1]
      unless token.match(/#{regex}/) 
        return false
      end
    end  
    true
  end
  
  def repair(split_line)
    CSV.generate_line(split_line.fields,{:col_sep => @delimiter})
  end

end

class SplitLine
  attr_accessor :fields
  def initialize(line,delim)
    @fields = CSV.parse_line(line,{:col_sep => delim})
  end                          

  def line_right_size?(expected_size)
    @fields.length == expected_size
  end
end
