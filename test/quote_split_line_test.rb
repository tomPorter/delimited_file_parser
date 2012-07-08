require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe "SplitLine Quote" do
  before do
    line = "\"aaa|bbb\"|123456.00000|000000.12345||04-21-2011 10:00:00|2012-02-27 11:31:06.427\n"
    @split_line = SplitLine.new(line,'|')
  end

  it "Check a line to see if it has the right number of fields when qualifiers used" do
    assert @split_line.line_right_size?(6)
  end
end
