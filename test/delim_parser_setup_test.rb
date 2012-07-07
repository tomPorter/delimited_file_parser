require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe DelimParser do
  before do
    @delim_parser = DelimParser.new('|',6)
  end

  it "should allow me to add several mask patterns" do
    position = 2
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    assert @delim_parser.add_mask(position,regex).must_equal 1
    position = 3
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    assert @delim_parser.add_mask(position,regex).must_equal 2
    position = 5
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert @delim_parser.add_mask(position,regex).must_equal 3
    position = 6
    regex = '\A\d{4}-\d{2}-\d{2} d{2}:d{2}:d[2}\.\d{3}\z' #match 2012-02-27 11:31:06.427  {timestamp}
    assert @delim_parser.add_mask(position,regex).must_equal 4
  end

  it "should throw an exception when I add a mask pattern with the same position as an existing one" do
    position = 2
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    @delim_parser.add_mask(position,regex)
    position = 2
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert_raises(DuplicateRegexPositionError) {@delim_parser.add_mask(position,regex)}
  end
end
