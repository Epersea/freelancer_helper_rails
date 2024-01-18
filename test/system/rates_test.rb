require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase
  setup do
    @rate = rates(:one)
  end

  test "visiting the index" do
    visit root_path
    assert_selector "h1", text: "Welcome to Freelancer Helper"
  end

  test "should create rate" do
    visit "/rate"
    
    fill_in "hours[hours_day]", with: "8"
    fill_in "hours[days_week]", with: "5"
    fill_in "earnings[net_monthly_salary]", with: "2500"

    click_on "Calculate"

    assert_text "Your minimum rate per hour"
  end

  test "should update Rate" do
    rate_id = Rate.last.id
    visit "/rate/#{rate_id}"

    click_on "here"

    assert_text "Edit your rate"
  end

  test "should destroy Rate" do
    rate_id = Rate.last.id
    visit "/rate/#{rate_id}"

    click_on "Delete"
    page.accept_alert
  
    assert_text "Welcome to Freelancer Helper"
  end
end
