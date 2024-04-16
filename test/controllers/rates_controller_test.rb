require "test_helper"

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elliots_rate = rates(:elliots_rate)
    @improved_input = rate_inputs(:improved_rate_input)
    @elliot = users(:elliot)
    @user_with_no_rate = users(:user_with_no_rate)
    login_as(@elliot)
  end

  test "should get index" do

    get root_path

    assert_response :success
    assert_select 'h1', 'Welcome to Freelancer Helper'
    assert_select 'h2', 'Get organized, work less, and earn more'
    assert_select 'p', 4
  end

  test "should get new" do
    login_as(@user_with_no_rate)

    get new_rate_path

    assert_response :success
    assert_select 'h1', 'Rate Calculator'
    assert_select 'form', 2
  end

  test "should create rate" do
    login_as(@user_with_no_rate)
    previous_rate_count = Rate.count

    post rate_index_path, params: {
      expenses: @improved_input["expenses"],
      hours: @improved_input["hours"],
      earnings: @improved_input["earnings"],
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
    assert_redirected_to rate_path(rate)
  end

  test "should show rate" do

    get rate_path(@elliots_rate)

    assert_response :success
    assert_select 'h2', "Your minimum rate per hour should be #{@elliots_rate.rate}"
    assert_includes response.body, "#{@elliots_rate.annual_expenses}"
    assert_includes response.body, "#{@elliots_rate.hours_day}"
    assert_includes response.body, "#{@elliots_rate.hours_year}"
    assert_includes response.body, "#{@elliots_rate.billable_percent}"
    assert_includes response.body, "#{@elliots_rate.net_month}"
    assert_includes response.body, "#{@elliots_rate.tax_percent}"
    assert_includes response.body, "#{@elliots_rate.gross_year}"
  end

  test "should get edit" do

    get edit_rate_path(@elliots_rate)

    assert_response :success
    assert_select 'h1', 'Edit your rate'
    assert_select 'form', 2
  end

  test "should update rate" do
    assert_equal @elliots_rate.rate, 42.3

    patch rate_path(@elliots_rate), params: {
      expenses: @improved_input["expenses"],
      hours: @improved_input["hours"],
      earnings: @improved_input["earnings"],
    }
   
    updated_rate = Rate.find(@elliots_rate.id)
    assert_equal updated_rate.rate, 60.1
    assert_redirected_to rate_path(@elliots_rate)
  end

  test "should destroy rate" do
    previous_rate_count = Rate.count

    delete rate_path(@elliots_rate)

    expected_rate_count = previous_rate_count - 1
    assert_equal Rate.count, expected_rate_count
    assert_redirected_to root_path
  end

  test "should add user id to rate when user is logged in" do

    post rate_index_path, params: {
      expenses: @improved_input["expenses"],
      hours: @improved_input["hours"],
      earnings: @improved_input["earnings"],
    }

    rate = Rate.last
    assert_equal rate.user_id, @elliot.id
  end
end
