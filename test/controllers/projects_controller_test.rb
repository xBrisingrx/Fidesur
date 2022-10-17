require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should get new" do
    get new_project_url
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post projects_url, params: { project: { active: @project.active, material_id: @project.material_id, name: @project.name, number: @project.number, price: @project.price, provider_id: @project.provider_id, status: @project.status, tecnical_direction: @project.tecnical_direction } }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch project_url(@project), params: { project: { active: @project.active, material_id: @project.material_id, name: @project.name, number: @project.number, price: @project.price, provider_id: @project.provider_id, status: @project.status, tecnical_direction: @project.tecnical_direction } }
    assert_redirected_to project_url(@project)
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete project_url(@project)
    end

    assert_redirected_to projects_url
  end
end
