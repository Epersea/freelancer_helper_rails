require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "user attributes must not be empty" do
    empty_user = User.new
    
    assert empty_user.invalid?
    assert empty_user.errors[:name].any?
    assert empty_user.errors[:email].any?
    assert empty_user.errors[:password_digest].any?
  end

  test "user name must be unique" do
    repeated_name_user = User.new(name: 'Darlene', email: 'darlene@gmail.com', password: 'secret')

    assert repeated_name_user.invalid?
    assert_equal ["has already been taken"], repeated_name_user.errors[:name]
  end
end