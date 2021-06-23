require 'test_helper'

class ClientFieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client_field = client_fields(:one)
  end

  test "should get index" do
    get client_fields_url
    assert_response :success
  end

  test "should get new" do
    get new_client_field_url
    assert_response :success
  end

  test "should create client_field" do
    assert_difference('ClientField.count') do
      post client_fields_url, params: { client_field: { active: @client_field.active, client_id: @client_field.client_id, detail: @client_field.detail, field_id: @client_field.field_id } }
    end

    assert_redirected_to client_field_url(ClientField.last)
  end

  test "should show client_field" do
    get client_field_url(@client_field)
    assert_response :success
  end

  test "should get edit" do
    get edit_client_field_url(@client_field)
    assert_response :success
  end

  test "should update client_field" do
    patch client_field_url(@client_field), params: { client_field: { active: @client_field.active, client_id: @client_field.client_id, detail: @client_field.detail, field_id: @client_field.field_id } }
    assert_redirected_to client_field_url(@client_field)
  end

  test "should destroy client_field" do
    assert_difference('ClientField.count', -1) do
      delete client_field_url(@client_field)
    end

    assert_redirected_to client_fields_url
  end
end
