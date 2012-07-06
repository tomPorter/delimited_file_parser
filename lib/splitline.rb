class SplitLine
  def initialize(line,delimiter)
    @fields = line.strip.split(delimiter)
  end

  def size
    @fields.length
  end
end
