require "test_helper"

class ClientTest < ActiveSupport::TestCase

  test "client attributes must not be empty" do
    client = Client.new

    assert client.invalid?
    assert client.errors[:name].any?
    assert client.errors[:user_id].any?
  end

  test "client attributes must be numeric" do
    client = Client.new

    client.hours_worked = 'abc'
    client.amount_billed = 'abc'

    assert client.invalid?
    assert_equal ["is not a number"], client.errors[:hours_worked]
    assert_equal ["is not a number"], client.errors[:amount_billed]
  end

  test "client attributes must be equal or greater than 0" do
    client = Client.new

    client.hours_worked = -1
    client.amount_billed = -7

    assert client.invalid?
    assert_equal ["must be greater than or equal to 0"], client.errors[:hours_worked]
    assert_equal ["must be greater than or equal to 0"], client.errors[:amount_billed]
  end

  test "validates a correct client" do
    client = Client.new

    client.name = "E Corp"
    client.user_id = users(:darlene).id
    client.hours_worked = 0
    client.amount_billed = 0

    assert client.valid?
  end
end
