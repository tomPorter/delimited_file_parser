require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe "DelimParser setup" do
  before do
    @delim_parser = DelimParser.new('|',6)
  end

  it "Can I add several mask patterns" do
    pos,regex = good_regex_set[0]
    assert @delim_parser.add_mask(pos,regex).must_equal 1
    pos,regex = good_regex_set[1]
    assert @delim_parser.add_mask(pos,regex).must_equal 2
    pos,regex = good_regex_set[2]
    assert @delim_parser.add_mask(pos,regex).must_equal 3
    pos,regex = good_regex_set[3]
    assert @delim_parser.add_mask(pos,regex).must_equal 4
  end

  it "Throw an exception when adding a mask with same position as an existing one" do
    position = 2
    regex = '\A\d+\.\d{6}\z' # match '0.000000'
    @delim_parser.add_mask(position,regex)
    position = 2
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert_raises(DuplicateRegexPositionError) {@delim_parser.add_mask(position,regex)}
  end

  it "Throw an exception when adding a mask with a position > expected fields" do
    position = 9
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert_raises(RegexPositionOutOfBoundsError) {@delim_parser.add_mask(position,regex)}
  end

  it "Throw an exception when adding a mask with a position < 1" do
    position = 0
    regex = '\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z' #match 6/17/2008 12:00:00 AM {dates}
    assert_raises(RegexPositionOutOfBoundsError) {@delim_parser.add_mask(position,regex)}
  end
end
