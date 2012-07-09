require 'csv'
class RegexPositionOutOfBoundsError < Exception
end
class DuplicateRegexPositionError < Exception
end
class DelimParser
  attr_reader :expected_length, :delimiter, :last_field_pos
  def initialize(delimiter,expected_length)
    @marker_fields = {}
    @expected_length = expected_length
    @delimiter = delimiter
    @last_field_pos = 0
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
      unless split_line.fields[position-1].match(/#{regex}/) 
        return false
      end
    end  
    true
  end
  
  def find_next_mismatch(split_line)
    fields_to_check = @marker_fields.reject { |position,regex| position < @last_field_pos}
    fields_to_check.each do |position,regex|
      unless split_line.fields[position-1].match(/#{regex}/)
        @last_field_pos = position
        return position
      end
      @last_field_pos
    end
  end
  
  def join_fields(field_array,position)
    #ToDo: Figure out how to handle if very first field (pos 1) has a mask assigned 
    #ToDo: and actual data field does not match.
    field_array.slice(position-2,position-1).join(@delim)
  end
  
  def repair(split_line)
    #ToDo: write me!
    until is_line_ok? do
      first_bad_pos = find_next_mismatch(split_line)
      temp_field = join_fields(split_line.fields,first_bad_pos)
    end
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
