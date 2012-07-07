begin; require 'turn/autorun'; rescue LoadError; end
Turn.config do |c|
 # use one of output formats:
 # :outline  - turn's original case/test outline mode [default]
 # :progress - indicates progress with progress bar
 # :dotted   - test/unit's traditional dot-progress mode
 # :pretty   - new pretty reporter
 # :marshal  - dump output as YAML (normal run mode only)
 # :cue      - interactive testing
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 #c.trace   = true
 # use humanized test names (works only with :outline format)
 #c.natural = true
end

def good_test_line
  "aaa|123456.000000|000000.123450||04/21/2011 12:00:00 AM|2012-02-27 11:31:06.427\n"
end

def bad_timestamp_line
  "aaa|123456.000000|000000.123450||04/21/2011 12:00:00 AM|12345.000000\n"
end

def good_regex_set
  regexes = []
  regexes << [2,'\A\d+\.\d{6}\z']
  regexes << [3,'\A\d+\.\d{6}\z']
  regexes << [5,'\A\d{1,2}/\d{1,2}/\d{4} 12:00:00 AM\z']
  regexes << [6,'\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d{3}\z']
  regexes
end
