require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'splitline'

describe SplitLine do
  before do
    line = "aaa|123456.00000|000000.12345||04-21-2011 10:00:00|2012-02-27 11:31:06.427\n"
    delim = '|'
    @split_line = SplitLine.new(line,delim,6)
  end
  it "should take a line and split it on the supplied delimiter" do
    @split_line.size.must_equal 6
  end
  it "should verify that a good line has the same number of fields as expected" do
    assert @split_line.size_right?
  end
  it "should allow me to add several mask patterns" do
    position = 2
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    assert @split_line.add_mask(position,regex).must_equal 1
    position = 3
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    assert @split_line.add_mask(position,regex).must_equal 2
    position = 5
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert @split_line.add_mask(position,regex).must_equal 3
    position = 5
    regex = '\A\d{4}-\d{2}-\d{2} d{2}:d{2}:d[2}\.\d{3}\z' #match 2012-02-27 11:31:06.427  {timestamp}
    assert @split_line.add_mask(position,regex).must_equal 4
  end
end
