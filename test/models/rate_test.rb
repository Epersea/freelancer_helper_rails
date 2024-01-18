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
end
