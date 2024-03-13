require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
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

  test "should show/edit user" do
    visit "/login"

    fill_in "Name", with: @darlene.name
    fill_in "Password", with: "secret"

    click_button "Login"
    click_on "My account"

    assert_text "My account"
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
    visit "/login"

    fill_in "Name", with: @darlene.name
    fill_in "Password", with: "secret"

    click_button "Login"
    click_on "My account"

    click_on "Delete user"
    page.accept_alert

    assert_text "User Darlene was successfully deleted"
  end
end