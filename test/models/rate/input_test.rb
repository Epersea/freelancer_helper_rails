require "test_helper"

class RateInputTest < ActiveSupport::TestCase

  test "is created when a rate is created" do

    rate = Rate.create_for(input_data)

    input = Rate::Input.find(rate.id)
    assert input.valid?
    assert_equal input.expenses, input_data_expenses
    assert_equal input.hours, input_data_hours
    assert_equal input.earnings, input_data_earnings
  end

  test "is updated when a rate is updated" do
    rate = Rate.last
    updated_input = Rate::Input.find(rate.id)

    rate.update(updated_input_data)

    updated_input = Rate::Input.find(rate.id)
    assert_equal updated_input.expenses, updated_input_data_expenses
    assert_equal updated_input.hours, updated_input_data_hours
    assert_equal updated_input.earnings, updated_input_data_earnings
  end

  test "is deleted when a rate is deleted" do
    previous_input_count = Rate::Input.count
    rate = Rate.last

    rate.destroy

    expected_input_count = previous_input_count - 1
    assert_equal Rate::Input.count, expected_input_count
  end

  def input_data
    {
      "expenses"=> input_data_expenses,
      "hours"=> input_data_hours,
      "earnings"=> input_data_earnings
    }
  end

  def updated_input_data
    {
      "expenses"=> updated_input_data_expenses,
      "hours"=> updated_input_data_hours,
      "earnings"=> updated_input_data_earnings
    }
  end

  def input_data_expenses
    {
      "long_term"=>[
          {"amount"=>"1500",
            "years"=>"3"},
          {"amount"=>"1600",
            "years"=>"4"},
          {"amount"=>"500",
            "years"=>"3"},
          {"amount"=>"2000",
            "years"=>"10"}
          ],
      "annual"=>"1500",
      "monthly"=>"500"
    }
  end

  def updated_input_data_expenses
    {
      "long_term"=>[
          {"amount"=>"2500",
            "years"=>"5"},
          {"amount"=>"600",
            "years"=>"4"},
          {"amount"=>"800",
            "years"=>"4"},
          {"amount"=>"1000",
            "years"=>"5"}
          ],
      "annual"=>"100",
      "monthly"=>"900"
    }
  end

  def input_data_hours
    {
      "hours_day"=>"8",
      "non_billable"=>"22",
      "days_week"=>"5",
      "holidays"=>"25",
      "training"=>"6",
      "sick"=>"6"
    }
  end

  def updated_input_data_hours
    {
      "hours_day"=>"7",
      "non_billable"=>"20",
      "days_week"=>"4",
      "holidays"=>"20",
      "training"=>"5",
      "sick"=>"7"
    }
  end

  def input_data_earnings
    {
      "net_month"=>"5000",
      "tax_percent"=>"20"
    }
  end

  def updated_input_data_earnings
    {
      "net_month"=>"3000",
      "tax_percent"=>"30"
    }
  end
end