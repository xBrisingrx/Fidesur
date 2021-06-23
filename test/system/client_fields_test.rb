require "application_system_test_case"

class ClientFieldsTest < ApplicationSystemTestCase
  setup do
    @client_field = client_fields(:one)
  end

  test "visiting the index" do
    visit client_fields_url
    assert_selector "h1", text: "Client Fields"
  end

  test "creating a Client field" do
    visit client_fields_url
    click_on "New Client Field"

    check "Active" if @client_field.active
    fill_in "Client", with: @client_field.client_id
    fill_in "Detail", with: @client_field.detail
    fill_in "Field", with: @client_field.field_id
    click_on "Create Client field"

    assert_text "Client field was successfully created"
    click_on "Back"
  end

  test "updating a Client field" do
    visit client_fields_url
    click_on "Edit", match: :first

    check "Active" if @client_field.active
    fill_in "Client", with: @client_field.client_id
    fill_in "Detail", with: @client_field.detail
    fill_in "Field", with: @client_field.field_id
    click_on "Update Client field"

    assert_text "Client field was successfully updated"
    click_on "Back"
  end

  test "destroying a Client field" do
    visit client_fields_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client field was successfully destroyed"
  end
end
