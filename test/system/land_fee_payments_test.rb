require "application_system_test_case"

class LandFeePaymentsTest < ApplicationSystemTestCase
  setup do
    @land_fee_payment = land_fee_payments(:one)
  end

  test "visiting the index" do
    visit land_fee_payments_url
    assert_selector "h1", text: "Land Fee Payments"
  end

  test "creating a Land fee payment" do
    visit land_fee_payments_url
    click_on "New Land Fee Payment"

    click_on "Create Land fee payment"

    assert_text "Land fee payment was successfully created"
    click_on "Back"
  end

  test "updating a Land fee payment" do
    visit land_fee_payments_url
    click_on "Edit", match: :first

    click_on "Update Land fee payment"

    assert_text "Land fee payment was successfully updated"
    click_on "Back"
  end

  test "destroying a Land fee payment" do
    visit land_fee_payments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Land fee payment was successfully destroyed"
  end
end
