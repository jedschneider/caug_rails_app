require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'json_parse'
require 'us_states'

class FluReport < ActiveRecord::Base
  has_many :us_states

  def setup_reports
    @uri = "http://flutracker.rhizalabs.com/flu/"
    @doc = Hpricot(open(@uri))
  end

  #takes the folder name as string input, returns the name without the trailing
  #slash
  def get_id(str)
    return str[0..11]
  end

  # returns array of the directories associating the reports
  def return_reports_list(doc)
    regex = /\d\//
    reports = []
    doc.search("body").search("a") do |link|
      if regex.match(link.get_attribute("href"))
        reports << link.get_attribute('href')
      end
    end
    reports
  end

  # returns the urls for the list of reports
  def return_reports_urls(doc)
    urls = []
    return_reports_list(doc).each do |folder|
      urls << @uri + folder + "states.js"
    end
    urls
  end

  def report_date_from_list(report)
    d = report # => "200909031530/"
    year, month, day = d[0..3].to_i, d[4..5].to_i, d[6..7].to_i
    Date.civil(year, month, day)
  end
  
  #returns the report for the associated index
  def get_json_data(str)
    @urls = return_reports_urls(@doc)
    regex = Regexp.new(report_url str)
    @urls.each do |report|
      if regex.match(report)
        @json_parse = JsonParse.new(report)
        @json_report = @json_parse.process_report
        return @json_report
      end
    end
  end

  def report_url(report)
    @uri + report + 'states.js'
  end

  def build_new_report
    #//TODO: make build new report method
    report = []
    
    report
  end
end

