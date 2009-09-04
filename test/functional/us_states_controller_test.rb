require 'test_helper'

class UsStatesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:us_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create us_state" do
    assert_difference('UsState.count') do
      post :create, :us_state => { }
    end

    assert_redirected_to us_state_path(assigns(:us_state))
  end

  test "should show us_state" do
    get :show, :id => us_states(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => us_states(:one).to_param
    assert_response :success
  end

  test "should update us_state" do
    put :update, :id => us_states(:one).to_param, :us_state => { }
    assert_redirected_to us_state_path(assigns(:us_state))
  end

  test "should destroy us_state" do
    assert_difference('UsState.count', -1) do
      delete :destroy, :id => us_states(:one).to_param
    end

    assert_redirected_to us_states_path
  end
end
