require "test_helper"

class RatesControllerTest < ActionDispatch::IntegrationTest

  test "should get new" do

    get "/register"

    assert_response :success
    assert_select 'h1', 'New user'
    assert_select 'form', 1
  end

  test "should create user" do
    previous_user_count = User.count

    post "/register", params: {
      user: {
        name: 'Mike',
        email: 'mickey@hotmail.com',
        password: 'sssshhhh',
        password_confirmation: 'sssshhhh'
      }
    }
 
    expected_user_count = previous_user_count + 1
    assert_equal User.count, expected_user_count
    user = User.last
    assert_equal user.name, 'Mike'
    assert_equal user.email, 'mickey@hotmail.com'
    assert_instance_of(String, user.password_digest)
    follow_redirect!
    assert_select 'p', 'User Mike was successfully created'
  end

end