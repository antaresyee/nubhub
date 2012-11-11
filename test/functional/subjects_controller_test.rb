require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get results" do
    get :results
    assert_response :success
  end

  test "should get show_courses" do
    get :show_courses
    assert_response :success
  end

  test "should get show_instructors" do
    get :show_instructors
    assert_response :success
  end

end
