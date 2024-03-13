require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  test "should register a new user" do
    visit "/register"
    
    fill_in "Name", with: "Dom"
    fill_in "Email", with: "dipierro@fbi.gov"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_on "Create User"

    assert_text 'User Dom was successfully created'
  end
end