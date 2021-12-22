require 'test_helper'

class LandFeesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @land_fee = land_fees(:one)
  end

  test "should get index" do
    get land_fees_url
    assert_response :success
  end

  test "should get new" do
    get new_land_fee_url
    assert_response :success
  end

  test "should create land_fee" do
    assert_difference('LandFee.count') do
      post land_fees_url, params: { land_fee: {  } }
    end

    assert_redirected_to land_fee_url(LandFee.last)
  end

  test "should show land_fee" do
    get land_fee_url(@land_fee)
    assert_response :success
  end

  test "should get edit" do
    get edit_land_fee_url(@land_fee)
    assert_response :success
  end

  test "should update land_fee" do
    patch land_fee_url(@land_fee), params: { land_fee: {  } }
    assert_redirected_to land_fee_url(@land_fee)
  end

  test "should destroy land_fee" do
    assert_difference('LandFee.count', -1) do
      delete land_fee_url(@land_fee)
    end

    assert_redirected_to land_fees_url
  end
end
