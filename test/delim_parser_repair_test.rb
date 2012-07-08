require 'minitest/spec'
require 'minitest/autorun'
require_relative 'minitest_helper'
require 'delim_parser'

describe "DelimParser repair" do
  before do
    @delim_parser = DelimParser.new('|',6)
    good_regex_set.each { |pos,regex| @delim_parser.add_mask(pos,regex) }
  end

  it "Check if bad line repaired correctly" do
    skip("Need mismatch finder first!")
    line = extra_after_first_test_line
    split_line = SplitLine.new(line,'|')
    refute @delim_parser.is_line_ok?(split_line)
    @delim_parser.repair(split_line).must_equal good_w_quoted_field_line
  end

end
