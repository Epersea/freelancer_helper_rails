require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
    @basic_rate = rates(:basic_rate)
  end

  test "should register a new user" do
    visit "/register"
    
    fill_in "Name", with: "Dom"
    fill_in "Email", with: "dipierro@fbi.gov"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_on "Create User"

    assert_text 'User Dom was successfully created'
  end

  test "should update user" do
    visit "/users/#{@user.id}/edit"

    fill_in "Name", with: "Dom"
    fill_in "Email", with: "dipierro@fbi.gov"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_on "Update User"

    assert_text 'User Dom was successfully updated'
  end
end