require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
    @basic_rate = rates(:basic_rate)
  end


  test "should log in" do
    visit "/login"

    fill_in "Name", with: @darlene.name
    fill_in "Password", with: "secret"

    click_on "Login"

    assert_text "#{@darlene.name}, this is your Freelancer Summary"
    assert_text "Your minimum rate per hour should be #{@basic_rate.rate}"
  end

  test "should log out" do
    visit "/login"

    fill_in "Name", with: @darlene.name
    fill_in "Password", with: "secret"

    click_on "Login"
    click_on "Logout"

    assert_text 'Logged out'
  end
end