require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe DelimParser do
  before do
    @delim_parser = DelimParser.new('|',6)
    good_regex_set.each { |pos,regex| @delim_parser.add_mask(pos,regex) }
    line = good_test_line
    @split_line = SplitLine.new(line,'|')
  end

  it "should check to see if the line has fields in the right places" do
    assert @delim_parser.is_line_ok?(@split_line)
  end

end
