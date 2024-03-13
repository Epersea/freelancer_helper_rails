require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  setup do
    @elliot = users(:elliot)
  end

  test "should add, edit and delete a client" do
    visit "/login"

    fill_in "Name", with: @elliot.name
    fill_in "Password", with: "secret"

    click_button "Login"

    click_on "Add client"

    assert_text "New client"

    fill_in "Name", with: "A"
    fill_in "Hours worked", with: "10"
    fill_in "Amount billed", with: "100"

    click_button "Create Client"

    assert_text "A"
    assert_text "Hours worked: 10.0"
    assert_text "Amount billed: 100.0"
    assert_text "Rate per hour: 10.0"

    click_on "Edit this client"

    assert_text "Edit client"

    fill_in "Amount billed", with: "200"

    click_button "Update Client"

    assert_text "Rate per hour: 20.0"

    click_on "Edit this client"
    click_on "Delete client"
    page.accept_alert

    assert_text "Client A was successfully deleted"
  end

end