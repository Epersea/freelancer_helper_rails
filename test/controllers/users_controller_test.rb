require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:darlene)
  end

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
  end

  test "should get edit" do

    post "/login", params: {
      name: @user.name,
      password: 'secret'
    }

    get "/users/#{@user.id}/edit"

    assert_response :success
    assert_select 'h1', 'Editing user'
    assert_select 'form', :minimum => 1
  end

  test "should update user" do
    user = User.find(@user.id)
    assert_equal user.name, 'Darlene'

    patch "/users/#{@user.id}", params: {
      user: {
        name: 'Dolores',
        email: 'darlene@fsociety.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }
   
    updated_user = User.find(@user.id)
    assert_equal updated_user.name, 'Dolores'
  end

  test "should destroy user" do
    previous_user_count = User.count

    delete "/users/#{@user.id}"

    expected_user_count = previous_user_count - 1
    assert_equal User.count, expected_user_count

    assert_redirected_to root_path
    follow_redirect!
    assert_select 'p', "User #{@user.name} was successfully deleted"
  end

  test "destroying a user destroys its associated rate" do
    previous_user_count = User.count
    previous_rate_count = Rate.count

    delete "/users/#{@user.id}"

    expected_user_count = previous_user_count - 1
    expected_rate_count = previous_rate_count - 1
    assert_equal User.count, expected_user_count
    assert_equal Rate.count, expected_rate_count
  end
end