require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'splitline'

describe SplitLine do
  before do
    line = "aaa|123456.00000|000000.12345||04-21-2011 10:00:00\n"
    delim = '|'
    @split_line = SplitLine.new(line,delim,5)
  end
  it "can take a line and split it on the supplied delimiter" do
    @split_line.size.must_equal 5
  end
end
