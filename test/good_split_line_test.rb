require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe SplitLine do
  before do
    line = "aaa|123456.00000|000000.12345||04-21-2011 10:00:00|2012-02-27 11:31:06.427\n"
    @split_line = SplitLine.new(line,'|')
  end
  it "should take a line and split it on the supplied delimiter" do
    @split_line.fields.length.must_equal 6
  end

  it "should check a line to see if it has the right number of fields" do
    assert @split_line.line_right_size?(6)
  end
end
