require "test_helper"

class MySummaryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:elliot)
  end

  test 'logs out a deleted user before doing an action that requires login' do
    login_as(@user)

    User.connection.execute("DELETE FROM users WHERE id = #{@user.id}")

    assert_not_nil session[:user_id]

    get my_summary_index_path

    assert_nil session[:user_id]
  end
end