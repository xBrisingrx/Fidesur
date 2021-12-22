require 'test_helper'

class LandFeePaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @land_fee_payment = land_fee_payments(:one)
  end

  test "should get index" do
    get land_fee_payments_url
    assert_response :success
  end

  test "should get new" do
    get new_land_fee_payment_url
    assert_response :success
  end

  test "should create land_fee_payment" do
    assert_difference('LandFeePayment.count') do
      post land_fee_payments_url, params: { land_fee_payment: {  } }
    end

    assert_redirected_to land_fee_payment_url(LandFeePayment.last)
  end

  test "should show land_fee_payment" do
    get land_fee_payment_url(@land_fee_payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_land_fee_payment_url(@land_fee_payment)
    assert_response :success
  end

  test "should update land_fee_payment" do
    patch land_fee_payment_url(@land_fee_payment), params: { land_fee_payment: {  } }
    assert_redirected_to land_fee_payment_url(@land_fee_payment)
  end

  test "should destroy land_fee_payment" do
    assert_difference('LandFeePayment.count', -1) do
      delete land_fee_payment_url(@land_fee_payment)
    end

    assert_redirected_to land_fee_payments_url
  end
end
