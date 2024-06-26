require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase

  setup do
    @elliot = users(:elliot)
    @darlene = users(:darlene)
  end

  test "should add a client" do
    login_as(@elliot)

    click_on "Add Client"

    assert_text "New client"

    fill_in "Name", with: "A"

    click_button "Create Client"

    assert_text "A"
    assert_text "Hours worked: 0"
    assert_text "Amount billed: 0"
    assert_text "Rate per hour: 0"
  end

  test "should edit and delete a client" do
    login_as(@darlene)

    click_on "My Clients"

    click_on "Edit this client", match: :first

    assert_text "Edit client"

    fill_in "Name", with: "Updated Client"

    click_button "Update Client"

    assert_text "Updated Client"

    click_on "Edit this client"
    click_on "Delete Client"
    page.accept_alert

    assert_text "Updated Client was successfully deleted"
  end

  test "should display index of clients" do

    login_as(@darlene)

    click_on "My Clients"

    assert_text "Darlene's clients"
    assert_text "E-Corp"
    assert_text "Hours worked: 10.0"
    assert_text "Amount billed: 1000.0"
    assert_text "Rate per hour: 100.0"
    assert_text "F-Corp"
    assert_text "Hours worked: 11.0"
    assert_text "Amount billed: 1650.0"
    assert_text "Rate per hour: 150.0"
  end

end