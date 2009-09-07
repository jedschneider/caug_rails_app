require 'us_states'
require 'json_parse'

class FluReportController < ApplicationController
  before_filter :get_new_reports, :only => :index
  
  def index
    @all_reports = FluReport.find(:all, :order=>'report_date')

    respond_to do |format|
      format.html
      format.xml {render :xml => @all_reports}
    end
  end

  def show
    total_flu_data(params[:id])
    @report = FluReport.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.xml {render :xml=>@report.us_states}
    end
  end

  def get_new_reports
    if !@new_reports_called
      flu_report = FluReport.new
      @doc = flu_report.setup_reports
      @reports = flu_report.return_reports_list(@doc)
      while more_reports?
        diff = @reports.count - @gathered_reports.length
        index = (@reports.count - diff) - 1
        report = @reports.fetch(index)    
        #id = flu_report.get_id(report).to_i
        report_date = flu_report.report_date_from_list(report)
        @json = flu_report.get_json_data(report) #=> array of json data
        fr = FluReport.new(:report_date=>report_date)
        if fr.save
          add_states_data(fr.id, flu_report.report_url(report), @json)
          total_flu_data(fr.id)
          FluReport.update(fr.id, :confirmed=> @confirmed, :suspected=>@suspected, :fatal=>@fatal)
        end
      end

      new_reports_called(true)
    end
  end

  def new_reports_called(value)
    @new_reports_called = value
  end

  # determines if there are more reports to add to the database
    def more_reports?
    @gathered_reports = FluReport.all
    if @gathered_reports.length < @reports.count
      true
    else false
    end
  end

  def add_states_data(flu_report_id, report_url, json_array)
    json_parse = JsonParse.new(report_url)
    us_states = US_STATES.new
    us_states.states.each do |state|
      name = state
      cases=confirmed=negative=suspected=fatal=0   
      cases = json_parse.get_value_for_state("cases", state)
      confirmed = json_parse.get_value_for_state('Confirmed', state)
      negative = json_parse.get_value_for_state('Negative',state)
      suspected = json_parse.get_value_for_state('Suspected', state)
      fatal = json_parse.get_value_for_state('Fatal', state)
      s = UsState.new(:flu_report_id=>flu_report_id, :name=>name, :cases=>cases, :confirmed=>confirmed, :negative=>negative, :suspected=>suspected, :fatal=>fatal)
      s.save
    end
  end

  def total_flu_data(flu_report_id)
    @report = FluReport.find_by_id(flu_report_id)
    @cases=@fatal=@suspected=@confirmed=0
    @report.us_states.collect(&:cases).each {|cases| @cases += cases}
    @report.us_states.collect(&:confirmed).each { |con| @confirmed += con }
    @report.us_states.collect(&:suspected).each { |sus| @suspected += sus }
    @report.us_states.collect(&:fatal).each {|fatal| @fatal += fatal }
    @report.attributes[:confirmed] = @confirmed
  end  
end