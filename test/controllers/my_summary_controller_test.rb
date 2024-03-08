require "test_helper"

class MySummaryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_with_info = users(:darlene)
    @rate = Rate.find_by(user_id: @user_with_info.id)
    @e_corp = clients(:ecorp)
    @f_corp = clients(:fcorp)

    @user_without_info = users(:elliot)
  end

  test "should show login prompt to a logged out user" do
    
    get "/my_summary"

    assert_redirected_to login_path
    follow_redirect!
    assert_select 'p', "Please log in to use this feature"
  end

  test "should show Rate to a logged in user with a rate" do

    login_as(@user_with_info)

    get "/my_summary"

    assert_select 'h1', "#{@user_with_info.name}, this is your Freelancer Summary"
    assert_select 'h3', "Your minimum rate per hour should be #{@rate.rate}"
  end

  test "should show invitation to fill rate to a logged in user without a rate" do

    login_as(@user_without_info)

    get "/my_summary"

    assert_select 'p', "Looks like you haven't provided any data about your goal rates."
    assert_select 'a', "Go to Rate Calculator"

  end

  test "should show Clients to a logged in user with clients" do
    login_as(@user_with_info)

    get "/my_summary"

    assert_select 'h3', "#{@e_corp.name}"
    assert_includes response.body, "#{@e_corp.hours_worked}"
    assert_includes response.body, "#{@e_corp.amount_billed}"
    assert_includes response.body, "#{@e_corp.rate}"
    assert_select 'h3', "#{@f_corp.name}"
    assert_includes response.body, "#{@f_corp.hours_worked}"
    assert_includes response.body, "#{@f_corp.amount_billed}"
    assert_includes response.body, "#{@f_corp.rate}"
  end

  test "should show invitation to add clients to a logged in user without clients" do

    login_as(@user_without_info)

    get "/my_summary"

    assert_select 'p', "Looks like you haven't provided any data about your clients."
    assert_select 'a', "Add client"
  end  
end