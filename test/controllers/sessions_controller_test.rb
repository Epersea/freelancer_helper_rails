require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:darlene)
  end

  test "should get new" do

    get "/session/new"

    assert_response :success
    assert_select 'h1', 'Please Log In'
    assert_select 'form', 1
  end

  test "should not show login page to logged in user" do

    login_as(@user)

    get "/session/new"

    assert_redirected_to root_path
    follow_redirect!
    assert_select 'p', 'You are already logged in'
  end

  test "should login an existing user" do

    login_as(@user)

    assert_equal session[:user_id], @user.id
    assert_redirected_to my_summary_index_path
  end

  test "user should not be logged in if password is wrong" do

    post "/session", params: {
      name: @user.name,
      password: 'wrong'
    }

    assert_redirected_to new_session_path
  end

  test "should log user out and delete session id" do
    
    login_as(@user)

    assert_equal session[:user_id], @user.id

    delete "/session"

    assert_nil session[:user_id]

  end

end