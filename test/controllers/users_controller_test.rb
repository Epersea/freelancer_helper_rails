require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    @darlene = users(:darlene)
  end

  test "should get new" do

    get new_user_path

    assert_response :success
    assert_select 'h1', 'New user'
    assert_select 'form', 1
  end

  test "should create user" do
    assert_difference -> {User.count}, 1 do
      post user_path, params: {
        user: {
          name: 'Gideon',
          email: 'gideon@allsafe.com',
          password: 'secret',
          password_confirmation: 'secret'
        }
      }
    end

    user = User.last
    assert_equal user.name, 'Gideon'
    assert_equal user.email, 'gideon@allsafe.com'
  end

  test "should show user" do

    login_as(@darlene)

    get user_path

    assert_response :success
    assert_select 'h1', 'My Account'
    assert_select 'p', 'Darlene'
    assert_select 'p', 'darlene@fsociety.com'
  end

  test "should get edit" do

    login_as(@darlene)

    get edit_user_path

    assert_response :success
    assert_select 'h1', 'Editing user'
    assert_select 'label', "Name"
    assert_select 'label', "Email"
    assert_select 'label', "Name"
    assert_select 'label', "Password confirmation"
  end

  test "should update user" do
    assert_equal @darlene.name, 'Darlene'
    
    login_as(@darlene)

    patch user_path, params: {
      user: {
        name: 'Dolores',
        email: 'darlene@fsociety.com',
        password: 'secret',
        password_confirmation: 'secret'
      }
    }
    
    updated_user = User.find(@darlene.id)
    assert_equal updated_user.name, 'Dolores'
  end

  test "should destroy user" do
    previous_user_count = User.count
    
    login_as(@darlene)
    delete user_path

    expected_user_count = previous_user_count - 1
    assert_equal User.count, expected_user_count

    assert_redirected_to root_path
    follow_redirect!
    assert_select 'p', "User #{@darlene.name} was successfully deleted"
  end

  test "destroying a user destroys its associated rate" do
    previous_user_count = User.count
    previous_rate_count = Rate.count

    login_as(@darlene)
    delete user_path

    expected_user_count = previous_user_count - 1
    expected_rate_count = previous_rate_count - 1
    assert_equal User.count, expected_user_count
    assert_equal Rate.count, expected_rate_count
  end

  test "destroying a user ends its associated session" do

    login_as(@darlene)

    assert_equal session[:user_id], @darlene.id

    delete user_path

    assert_nil session[:user_id]
  end

  test "destroying a user destroys its associated clients" do
    previous_user_count = User.count
    previous_client_count = Client.count

    login_as(@darlene)
    delete user_path

    expected_user_count = previous_user_count - 1
    expected_client_count = previous_client_count - 2
    assert_equal User.count, expected_user_count
    assert_equal Client.count, expected_client_count
  end
end