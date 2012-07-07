require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe DelimParser do
  before do
    @delim_parser = DelimParser.new('|',6)
    good_regex_set.each { |pos,regex| @delim_parser.add_mask(pos,regex) }
  end

  it "should check to see if the line has fields in the right places" do
    line = good_test_line
    split_line = SplitLine.new(line,'|')
    assert @delim_parser.is_line_ok?(split_line)
  end

  it "should check to see if a bad line does not have fields in right places" do
    line = bad_timestamp_line
    split_line = SplitLine.new(line,'|')
    refute @delim_parser.is_line_ok?(split_line)
  end

end
