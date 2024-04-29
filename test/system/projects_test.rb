require "application_system_test_case"

class ProjectsTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
    login_as(@darlene)
  end

  test "should display an index of projects" do
    click_on "See E-Corp's projects"

    assert_text "E-Corp's projects"
    assert_text "Looks like you don't have any projects for this client yet. Click on the button below to start adding!"

    click_on "My Summary"
    click_on "See F-Corp's projects"

    assert_text "F-Corp's projects"

    assert_text "Logo Design"
    assert_text "Hours worked: 10.0"
    assert_text "Amount billed: 1650.0"
    assert_text "Rate per hour: 165.0"
    assert_text "Start date: 2024-04-01"
    assert_text "End date: 2024-04-03"
    assert_text "Description: Logo redesign with bolder colors"
    assert_text "Website translation"
    assert_text "Hours worked: 6.0"
    assert_text "Amount billed: 360.0"
    assert_text "Rate per hour: 60.0"
    assert_text "Start date: 2024-04-03"
    assert_text "End date: 2024-04-05"
    assert_text "Website translation - Homepage, About Me, Careers"
  end

  test "should add and delete projects" do
    click_on "See E-Corp's projects"

    click_on "Add Project"

    fill_in "Name", with: "Software consulting"
    fill_in "Hours worked", with: "20"
    fill_in "Amount billed", with: "5000"
    fill_in "Start date", with: Date.new(2023, 3, 10)
    fill_in "End date", with: Date.new(2023, 3, 20)
    
    click_on "Create Project"

    assert_text "Software consulting"
    assert_text "Client: E-Corp"
    assert_text "Hours worked: 20.0"
    assert_text "Amount billed: 5000.0"
    assert_text "Rate per hour: 250.0"
    assert_text "Start date: 2023-03-10"
    assert_text "End date: 2023-03-20"

    click_on "Edit this project"
    click_on "Delete Project"
    page.accept_alert

    assert_text "Project Software consulting was successfully deleted"
    assert_text "Looks like you don't have any projects for this client yet. Click on the button below to start adding!"
  end

  test "should edit a project" do
    click_on "See F-Corp's projects"

    click_on "Edit this project", match: :first

    fill_in "Name", with: "Logo redesign"
    fill_in "Hours worked", with: "15"
    fill_in "Amount billed", with: "2500"
    fill_in "Description", with: "Logo redesign with bolder colors and modern fonts"

    click_on "Update Project"

    assert_text "Logo redesign"
    assert_text "Client: F-Corp"
    assert_text "Hours worked: 15.0"
    assert_text "Amount billed: 2500.0"
    assert_text "Rate per hour: 166.67"
    assert_text "Start date: 2024-04-01"
    assert_text "End date: 2024-04-03"
    assert_text "Description: Logo redesign with bolder colors and modern fonts"
  end
end