require "test_helper"

class RateTest < ActiveSupport::TestCase
  test "rate attributes must not be empty" do
    rate = Rate.new

    assert rate.invalid?
    assert rate.errors[:rate].any?
    assert rate.errors[:annual_expenses].any?
    assert rate.errors[:hours_day].any?
    assert rate.errors[:hours_year].any?
    assert rate.errors[:billable_percent].any?
    assert rate.errors[:net_month].any?
    assert rate.errors[:tax_percent].any?
    assert rate.errors[:gross_year].any?
  end

  test "rate attributes must be numeric" do
    rate = Rate.new

    rate.rate = 'abc'
    rate.annual_expenses = 'abc'
    rate.hours_day = 'abc'
    rate.hours_year = 'abc'
    rate.billable_percent = 'abc'
    rate.net_month = 'abc'
    rate.tax_percent = 'abc'
    rate.gross_year = 'abc'

    assert rate.invalid?
    assert_equal ["is not a number"], rate.errors[:rate]
    assert_equal ["is not a number"], rate.errors[:annual_expenses]
    assert_equal ["is not a number"], rate.errors[:hours_day]
    assert_equal ["is not a number"], rate.errors[:hours_year]
    assert_equal ["is not a number"], rate.errors[:billable_percent]
    assert_equal ["is not a number"], rate.errors[:net_month]
    assert_equal ["is not a number"], rate.errors[:tax_percent]
    assert_equal ["is not a number"], rate.errors[:gross_year]
  end

  test 'hours year should be equal or greater than 1' do
    rate = Rate.new

    rate.hours_year = -7

    assert rate.invalid?
    assert_equal ["must be greater than or equal to 1"], rate.errors[:hours_year]

    rate.hours_year = 0

    assert rate.invalid?
    assert_equal ["must be greater than or equal to 1"], rate.errors[:hours_year]
  end

  test 'net month should be equal or greater than 1' do
    rate = Rate.new

    rate.net_month = -7

    assert rate.invalid?
    assert_equal ["must be greater than or equal to 1"], rate.errors[:net_month]

    rate.net_month = 0

    assert rate.invalid?
    assert_equal ["must be greater than or equal to 1"], rate.errors[:net_month]
  end

  test 'validates a correct rate' do
    rate = Rate.new

    rate.rate = 42.3
    rate.annual_expenses = 5250
    rate.hours_day = 6
    rate.hours_year = 1070.4
    rate.billable_percent = 80
    rate.net_month = 2500
    rate.tax_percent = 25
    rate.gross_year = 45250
    rate.user_info = {"expenses":{"long_term":[{"amount":"1500","years":"5"},{"amount":"800","years":"4"},{"amount":"300","years":"6"},{"amount":"1000","years":"10"}],"annual":"1000","monthly":"300"},"hours":{"hours_day":"6","non_billable":"20","days_week":"5","holidays":"25","training":"6","sick":"6"},"earnings":{"net_monthly_salary":"2500","tax_percent":"25"},"commit":"Calculate"}

    assert rate.valid?
  end
end
