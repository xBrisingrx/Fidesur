require 'test_helper'

class LandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lands_index_url
    assert_response :success
  end

  test "should get new" do
    get lands_new_url
    assert_response :success
  end

  test "should get create" do
    get lands_create_url
    assert_response :success
  end

  test "should get edit" do
    get lands_edit_url
    assert_response :success
  end

  test "should get update" do
    get lands_update_url
    assert_response :success
  end

end
