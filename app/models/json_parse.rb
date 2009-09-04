require 'rubygems'
require 'json'
require 'open-uri'

class JsonParse

  def initialize(report_as_url)
    @url = report_as_url
    @confirmed_cases = Hash.new
    @report = []
    process_report
  end

  # returns an array
  def process_report
    begin
      file = open(@url)
      report = JSON.parse(file.read)
      #@confirmed_cases = get_confirmed_cases(report)
      #@confirmed_cases
      @report = report
    rescue Errno::ENOENT
      nil
    end
  end

  # returns a value for the key and state provided, for the json_parse object
  # @json_parse.get_value_for_state("Confirmed", "NM")
  def get_value_for_state(k, us_state)
    if @report
      @report.each do |s|
        if (s.fetch('state')==us_state)
          return s.fetch(k)
        end
      end
    end
  end

protected
  def get_confirmed_cases(report)
    temp_cases = Hash.new
    report.each do |item|
      if item.key?("state")&& item.key?("Confirmed")
        state, cases = item.fetch("state"), item.fetch("Confirmed")
        temp_cases[state]=cases
      end
    end
    temp_cases
  end

end