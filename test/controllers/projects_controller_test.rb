require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @darlene = users(:darlene)
    login_as(@darlene)
    @f_corp = clients(:fcorp)
    @logo = projects(:logo)
    @translation = projects(:translation)
  end

  test "should get index" do

    get client_projects_path(@f_corp)

    assert_response :success
    assert_select 'h1', "#{@f_corp.name}'s projects"
    assert_select 'h3', "#{@logo.name}"
    assert_includes response.body, "#{@logo.hours_worked}"
    assert_includes response.body, "#{@logo.amount_billed}"
    assert_includes response.body, "#{@logo.rate}"
    assert_select 'h3', "#{@translation.name}"
    assert_includes response.body, "#{@translation.hours_worked}"
    assert_includes response.body, "#{@translation.amount_billed}"
    assert_includes response.body, "#{@translation.rate}"
  end

  test "should get new" do
    get new_client_project_path(@f_corp)

    assert_response :success
    assert_select 'h1', 'New Project'
    assert_select 'label', 'Name'
    assert_select 'label', 'Hours worked'
    assert_select 'label', 'Amount billed'
    assert_select 'label', 'Description (optional)'
  end
end