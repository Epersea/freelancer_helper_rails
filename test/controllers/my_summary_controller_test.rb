require "test_helper"

class MySummaryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:darlene)
    @rate = Rate.find_by(user_id: @user.id)
  end

  test "should show Rate to a logged in user" do

    post "/login", params: {
      name: 'Darlene',
      password: 'secret'
    }

    get "/my_summary"

    assert_select 'h1', "#{@user.name}, this is your Freelancer Summary"
    assert_select 'h3', "Your minimum rate per hour should be #{@rate.rate}"
  end

  test "should show login prompt to a logged out user" do
    
    get "/my_summary"

    assert_select 'h1', "Freelancer Summary"
    assert_select 'p', "Please Log In to see your information here."
  end
end