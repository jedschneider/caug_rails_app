require 'test_helper'
require 'redgreen'
require 'flu_report'
require 'test/unit'
require 'net/http'
require 'date'

class FluReportTest < Test::Unit::TestCase
  def setup
    @flu_report = FluReport.new
  end

  def test_new_flu_report
    assert_equal(FluReport, @flu_report.class,
      'should create a new flu report')
  end

  def test_return_reports_list
    files = @flu_report.setup_reports
    assert_equal(Array, @flu_report.return_reports_list(files).class,
      'Should return an array object')
  end

  def test_return_reports_urls
    files = @flu_report.setup_reports
    array = @flu_report.return_reports_urls(files)
    assert_equal(Array, array.class,
      'Should return an array')
    array.each do |url|
         assert(202, Net::HTTP.get(URI.parse(url)) {|res| res.value})
       end
  end

  def test_get_date
    today = Date.today
    tomorrow = today.next
    yesterday = today - 1
    files = @flu_report.setup_reports
    reports = @flu_report.return_reports_list(files)

    match = Regexp.new stringify_date(today)
    assert_match(match, reports.last,
      'today should be the last report')

    match = Regexp.new stringify_date(tomorrow)
    assert_no_match(match, reports.last,
      'tomorrow should not be the last report')
    
    match = Regexp.new stringify_date(yesterday)
    assert_match(match, reports.fetch(reports.count-2),
      'yesterday should be the second to last directory')
  end

  def test_get_json_data
    files = @flu_report.setup_reports
    array = @flu_report.return_reports_list(files)
    report = array.fetch(32)
    @flu_report.get_json_data(report)
    assert_instance_of(Array,@flu_report.get_json_data(report),
    'Should return Array of JSON data')
  end

  #def test_get_states
  #  assert_instance_of(Array, @flu_report.get_states, "Should be an array")
  #  @states = @flu_report.get_states
  #  assert_equal("AK", @states.first, "should be the state AK")
  #end
  #
  #def test_more_reports
  # assert_equal(true, @flu_report.more_reports?, 'should return true')
  #end

protected
  # for testing the array of dates
  def stringify_date(d)
    y = d.year.to_s
    if d.month < 10
      m = "0" + d.month.to_s
      else m = d.month.to_s
    end
    if d.day < 10
      day = "0" + d.day.to_s
      else day = d.day.to_s
    end
    return y + m + day
  end
end
