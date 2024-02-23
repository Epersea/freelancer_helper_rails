require "test_helper"

class MySummaryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_with_rate = users(:darlene)
    @rate = Rate.find_by(user_id: @user_with_rate.id)
    @user_without_rate = users(:elliot)
  end

  test "should show Rate to a logged in user with a rate" do

    post "/login", params: {
      name: @user_with_rate.name,
      password: 'secret'
    }

    get "/my_summary"

    assert_select 'h1', "#{@user_with_rate.name}, this is your Freelancer Summary"
    assert_select 'h3', "Your minimum rate per hour should be #{@rate.rate}"
  end

  test "should show invitation to fill rate to a logged in user without a rate" do

    post "/login", params: {
      name: @user_without_rate.name,
      password: 'secret'
    }

    get "/my_summary"

    assert_select 'h1', "Freelancer Summary"
    assert_select 'p', "Looks like you haven't provided any data about your freelancer journey. Our Rate Calculator is a great place to start!"

  end

  test "should show login prompt to a logged out user" do
    
    get "/my_summary"

    assert_redirected_to login_path
    follow_redirect!
    assert_select 'p', "Please log in to use this feature"
  end
end