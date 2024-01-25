require "test_helper"

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @input_two = rate_inputs(:two)
  end

  test "should get index" do

    get "/"

    assert_response :success
    assert_select 'h1', 'Welcome to Freelancer Helper'
    assert_select 'h2', 'Get organized, work less, and earn more'
    assert_select 'p', minimum: 4
  end

  test "should get new" do

    get "/rate"

    assert_response :success
    assert_select 'h1', 'Rate Calculator'
    assert_select 'form', 1
  end

  test "should create rate" do
    previous_rate_count = Rate.count

    post "/rate", params: {
      expenses: @input_two["expenses"],
      hours: @input_two["hours"],
      earnings: @input_two["earnings"],
    }
 
    expected_rate_count = previous_rate_count + 1
    assert_equal Rate.count, expected_rate_count
    rate = Rate.last
    assert_equal rate.rate, 60.1
    assert_equal rate.annual_expenses, 8666
    assert_equal rate.hours_day, 8
    assert_equal rate.hours_year, 1391.5
    assert_equal rate.billable_percent, 78
    assert_equal rate.net_month, 5000
    assert_equal rate.tax_percent, 20
    assert_equal rate.gross_year, 83666
    assert_redirected_to "/rate/#{rate.id}"
  end

  test "should show rate" do
    rate = Rate.last
    rate_id = rate.id

    get "/rate/#{rate_id}"

    assert_response :success
    assert_select 'h1', 'Your minimum rate per hour'
    assert_select 'h3', "Your minimum rate per hour should be #{rate.rate}"
    assert_includes response.body, "#{rate.annual_expenses}"
    assert_includes response.body, "#{rate.hours_day}"
    assert_includes response.body, "#{rate.hours_year}"
    assert_includes response.body, "#{rate.billable_percent}"
    assert_includes response.body, "#{rate.net_month}"
    assert_includes response.body, "#{rate.tax_percent}"
    assert_includes response.body, "#{rate.gross_year}"
  end

  test "should get edit" do
    rate = Rate.last
    rate_id = rate.id

    get "/rate/#{rate_id}/edit"

    assert_response :success
    assert_select 'h1', 'Edit your rate'
    assert_select 'form', 1
  end

  test "should update rate" do
    rate = Rate.last
    rate_id = rate.id
    assert_equal rate.rate, 42.3

    patch "/rate/#{rate_id}", params: {
      expenses: @input_two["expenses"],
      hours: @input_two["hours"],
      earnings: @input_two["earnings"],
    }
   
    updated_rate = Rate.find(rate_id)
    assert_equal updated_rate.rate, 60.1
    assert_redirected_to "/rate/#{rate_id}"
  end

  test "should destroy rate" do
    rate = Rate.last
    rate_id = rate.id
    previous_rate_count = Rate.count

    delete "/rate/#{rate_id}"

    expected_rate_count = previous_rate_count - 1
    assert_equal Rate.count, expected_rate_count
    assert_redirected_to root_path
  end
end
