class SplitLine
  def initialize(line,delimiter,expected_length)
    @fields = line.strip.split(delimiter)
    @expected_length = expected_length
  end

  def size
    @fields.length
  end

  def size_right?
    @fields.length == @expected_length
  end
end
