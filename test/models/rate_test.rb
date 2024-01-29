require "test_helper"

class RateTest < ActiveSupport::TestCase

  setup do
    @basic_input = rate_inputs(:basic_rate_input)
    @improved_input∫ = rate_inputs(:improved_rate_input)
  end

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

    assert rate.valid?
  end

  test "an input is created when a rate is created" do

    rate = Rate.create_for(expenses: @basic_input["expenses"], hours: @basic_input["hours"], earnings: @basic_input["earnings"],)

    input = Rate::Input.find_by(rate_id: rate.id)
    assert input.valid?
    assert_equal input.expenses, @basic_input["expenses"]
    assert_equal input.hours, @basic_input["hours"]
    assert_equal input.earnings, @basic_input["earnings"]
  end

  test "an input is updated when a rate is updated" do
    rate = Rate.last

    rate.update_for(expenses: @improved_input∫["expenses"], hours: @improved_input∫["hours"], earnings: @improved_input∫["earnings"])

    updated_input = Rate::Input.find_by(rate_id: rate.id)
    assert_equal updated_input.expenses, @improved_input∫["expenses"]
    assert_equal updated_input.hours, @improved_input∫["hours"]
    assert_equal updated_input.earnings, @improved_input∫["earnings"]
  end
end
