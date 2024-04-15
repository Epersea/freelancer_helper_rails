require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
  end

  test "should register a new user" do
    visit "/user/new"
    
    fill_in "Name", with: "Dom"
    fill_in "Email", with: "dipierro@fbi.gov"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_on "Create User"

    assert_text 'User Dom was successfully created'
  end

  test "should show/edit user" do
    login_as(@darlene)

    click_on "My Account"

    assert_text "My Account"
    assert_text "#{@darlene.name}"
    assert_text "#{@darlene.email}"

    click_on "Edit this user"

    fill_in "Name", with: "Edited user"
    fill_in "Email", with: "edited@email.com"
    fill_in "Password", with: "secret"
    fill_in "Password confirmation", with: "secret"

    click_on "Update User"

    assert_text "User Edited user was successfully updated"
  end

  test "should delete user" do
    login_as(@darlene)
    
    click_on "My Account"

    click_on "Delete User"
    page.accept_alert

    assert_text "User Darlene was successfully deleted"
  end
end