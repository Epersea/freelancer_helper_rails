require "test_helper"

class MySummaryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_with_info = users(:darlene)
    @rate = Rate.find_by(user_id: @user_with_info.id)
    @e_corp = clients(:ecorp)
    @f_corp = clients(:fcorp)

    @user_without_info = users(:user_with_no_rate)
    @user_with_low_rates = users(:user_with_low_rates)
    @user_with_mixed_rates = users(:user_with_mixed_rates)
  end

  test "should show login prompt to a logged out user" do
    
    get my_summary_index_path

    assert_redirected_to new_session_path
    follow_redirect!
    assert_select 'p', "Please log in to use this feature"
  end

  test "should show Rate to a logged in user with a rate" do

    login_as(@user_with_info)

    get my_summary_index_path

    assert_select 'h1', "#{@user_with_info.name}, this is your Freelancer Summary"
    assert_select 'h2', "Your minimum rate per hour should be #{@rate.rate}"
  end

  test "should show invitation to fill rate to a logged in user without a rate" do

    login_as(@user_without_info)

    get my_summary_index_path

    assert_select 'p', "Looks like you haven't provided any data about your goal rates."
    assert_select 'a', "Go to Rate Calculator"

  end

  test "should show Clients to a logged in user with clients" do
    login_as(@user_with_info)

    get my_summary_index_path

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

    get my_summary_index_path

    assert_select 'p', "Looks like you haven't provided any data about your clients."
    assert_select 'a', "Add Client"
  end  

  test "should display message for user with client rates above goal rates" do
    login_as(@user_with_info)
    
    get my_summary_index_path

    assert_select 'p', "All your clients are above your goal rate. Good job! Why not being a bit more ambitious?"
  end

  test "should display message for user with client rates above and below goal rates" do
    login_as(users(:user_with_mixed_rates))

    get my_summary_index_path

    assert_select 'p', "Some of your clients are below your goal rate. Maybe you need to brush up your negotiation skills a bit?"
  end

  test "should display message for user with client rates below goal rates" do
    login_as(users(:user_with_low_rates))

    get my_summary_index_path

    assert_select 'p', "All your clients are below your goal rate. It's time to give yourself a raise!"
  end
end