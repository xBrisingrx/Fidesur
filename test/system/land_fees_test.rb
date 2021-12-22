require "application_system_test_case"

class LandFeesTest < ApplicationSystemTestCase
  setup do
    @land_fee = land_fees(:one)
  end

  test "visiting the index" do
    visit land_fees_url
    assert_selector "h1", text: "Land Fees"
  end

  test "creating a Land fee" do
    visit land_fees_url
    click_on "New Land Fee"

    click_on "Create Land fee"

    assert_text "Land fee was successfully created"
    click_on "Back"
  end

  test "updating a Land fee" do
    visit land_fees_url
    click_on "Edit", match: :first

    click_on "Update Land fee"

    assert_text "Land fee was successfully updated"
    click_on "Back"
  end

  test "destroying a Land fee" do
    visit land_fees_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Land fee was successfully destroyed"
  end
end
