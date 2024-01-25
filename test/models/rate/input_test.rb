require "test_helper"

class RateInputTest < ActiveSupport::TestCase

  setup do
    @input_one = rate_inputs(:one)
    @input_two = rate_inputs(:two)
  end

  test "is created when a rate is created" do

    rate = Rate.create_for(input_one_data)

    input = Rate::Input.find(rate.id)
    assert input.valid?
    assert_equal input.expenses, @input_one["expenses"]
    assert_equal input.hours, @input_one["hours"]
    assert_equal input.earnings, @input_one["earnings"]
  end

  test "is updated when a rate is updated" do
    rate = Rate.last

    rate.update(input_two_data)

    updated_input = Rate::Input.find(rate.id)
    assert_equal updated_input.expenses, @input_two["expenses"]
    assert_equal updated_input.hours, @input_two["hours"]
    assert_equal updated_input.earnings, @input_two["earnings"]
  end

  def input_one_data
    {
      expenses: @input_one["expenses"],
      hours: @input_one["hours"],
      earnings: @input_one["earnings"],
    }
  end

  def input_two_data
    {
      expenses: @input_two["expenses"],
      hours: @input_two["hours"],
      earnings: @input_two["earnings"],
    }
  end
end