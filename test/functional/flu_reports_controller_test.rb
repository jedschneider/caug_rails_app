require 'test_helper'

class FluReportsControllerTest < ActionController::TestCase

  def test_before_filter
    @controller = FluReportsController.new
    assert_instance_of(FluReportsController, @controller)
    assert_equal(true, @controller.get_new_reports )
  end

  def test_index
    
  end
end
