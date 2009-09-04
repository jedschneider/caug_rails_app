require "test_helper"
require 'redgreen'
require "json_parse"
require 'test/unit'

## expected use:
##
## @json_parse = JasonParse.new(url_to_flu_report)
## @flu_cases = @json_parse.process_report
##
## @flu_cases should be a hash of the value from that JSON flu report
##

class JsonParseTest < Test::Unit::TestCase
  def setup
    @url = 'http://flutracker.rhizalabs.com/flu/200909011539/states.js'
  end

  def setup_valid_json_parse_object
    JsonParse.new(@url)
  end

  def test_fail
    assert('false', 'Assertion was false')
  end

  def test_setup
    assert_equal(@url.class, String, 'Should be a String')
  end

  def test_json_is_class
    assert('true', JsonParse)
  end

  def test_json_parse_new
    assert(JsonParse, 'Should instantiate JsonParse object')
    assert(JsonParse.new(@url), 'Should take a report parameter')
  end

  def test_json_parse_process_report
    @json_parse = setup_valid_json_parse_object
    assert_equal(Array, @json_parse.process_report.class, 
      'Should return an array object')
    @flu_cases = @json_parse.process_report
    assert_equal(@flu_cases.class, Array, '@flu_cases should be a hash object')
    assert_equal(@flu_cases.size, 51, "Length should be 51")
  end

  def test_json_parse_invalid_url
    @json_parse = JsonParse.new('invalid_url')
    assert_equal(@json_parse.process_report, nil, '@json_parse should be null')
  end

  def test_get_value_for_state
     k, state = "Confirmed", "NM"
     @json_parse = setup_valid_json_parse_object
     array = @json_parse.process_report
     assert_equal(Array, array.class, 'Should return an array object')
     assert_equal(599, @json_parse.get_value_for_state(k, state))
     k = 'cases'
     assert_equal(604, @json_parse.get_value_for_state(k, state))
  end

end