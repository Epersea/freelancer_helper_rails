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
end