require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @darlene = users(:darlene)
    @f_corp = clients(:fcorp)
    @e_corp = clients(:ecorp)
    @logo = projects(:logo)
    @translation = projects(:translation)

    login_as(@darlene)
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

  test "should create project" do
    previous_project_count = Project.count

    post client_projects_path(@e_corp), params: {
      project: {
        name: "New Project",
        hours_worked: 5,
        amount_billed: 300,
        start_date: Date.new(2024, 4, 11),
        end_date: Date.new(2024, 4, 15),
        description: "Initial consulting session"
      }
    }

    expected_project_count = previous_project_count + 1
    assert_equal Project.count, expected_project_count
    project = Project.last
    assert_equal project.name, "New Project"
    assert_equal project.hours_worked, 5
    assert_equal project.amount_billed, 300
    assert_equal project.client_id, @e_corp.id
    assert_equal project.rate, 60

    assert_redirected_to project_path(project)
  end

  test "should show project" do

    get project_path(@logo)

    assert_response :success
    assert_select 'h3', "#{@logo.name}"
    assert_includes response.body, "#{@logo.hours_worked}"
    assert_includes response.body, "#{@logo.amount_billed}"
    assert_includes response.body, "#{@logo.rate}"
  end

  test "should get edit" do 

    get edit_project_path(@logo)

    assert_response :success
    assert_select 'h1', 'Edit project'
    assert_select 'label', "Name"
    assert_select 'label', "Hours worked"
    assert_select 'label', "Amount billed"
    assert_select 'label', "Description (optional)"
  end

  test "should update project" do

    patch project_path(@translation), params: {
      project: {
        name: "Updated project",
        hours_worked: 12,
        amount_billed: 600
      }
    }

    updated_project = Project.find(@translation.id)
    assert_equal updated_project.name, "Updated project"
    assert_equal updated_project.hours_worked, 12
    assert_equal updated_project.amount_billed, 600
    assert_equal updated_project.rate, 50

    assert_redirected_to project_path(@translation)
  end

  test "should destroy project" do
    previous_project_count = Project.count

    delete project_path(@logo)

    expected_project_count = previous_project_count - 1
    assert_equal Project.count, expected_project_count

    assert_redirected_to client_projects_path(@f_corp)
    follow_redirect!
    assert_select 'p', "Project #{@logo.name} was successfully deleted"
  end
end