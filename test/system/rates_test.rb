require "application_system_test_case"

class RatesTest < ApplicationSystemTestCase

  setup do
    @basic_rate = rates(:basic_rate)
    @darlene = users(:darlene)
    @user_with_no_rate = users(:user_with_no_rate)
  end

  test "visiting the index" do
    visit root_path
    assert_selector "h1", text: "Welcome to Freelancer Helper"
  end

  test "should create rate" do
    login_as(@user_with_no_rate)

    click_on "Go to Rate Calculator"
    
    fill_in "expenses[annual]", with: "1000"
    fill_in "expenses[monthly]", with: "300"
    fill_in "hours[hours_day]", with: "7"
    fill_in "hours[non_billable]", with: "20"
    fill_in "hours[days_week]", with: "4"
    fill_in "earnings[net_month]", with: "2500"
    fill_in "earnings[tax_percent]", with: "30"

    click_on "Calculate"

    assert_text "Your minimum rate per hour should be 40.7"
  end

  test "should get edit" do
    login_as(@darlene)

    click_on "Edit"

    assert_text "Edit your rate"
  end

  test "should update rate" do
    login_as(@darlene)

    click_on "Edit"

    fill_in "earnings[net_month]", with: "3000"

    click_on "Calculate"

    assert_text "Your minimum rate per hour should be 49.7"
  end

  test "should destroy Rate" do
    login_as(@darlene)

    click_on "Delete"
    page.accept_alert
  
    assert_text "Welcome to Freelancer Helper"
  end
end
