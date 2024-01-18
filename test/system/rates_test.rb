require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "visiting the index" do
    visit rates_url
    assert_selector "h1", text: "Rates"
  end

  test "should create rate" do
    visit rates_url
    click_on "New rate"

    click_on "Create Rate"

    assert_text "Rate was successfully created"
    click_on "Back"
  end

  test "should update Rate" do
    visit rate_url(@rate)
    click_on "Edit this rate", match: :first

    click_on "Update Rate"

    assert_text "Rate was successfully updated"
    click_on "Back"
  end

  test "should destroy Rate" do
    visit rate_url(@rate)
    click_on "Destroy this rate", match: :first

    assert_text "Rate was successfully destroyed"
  end
end
