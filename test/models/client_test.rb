require "test_helper"

class ClientTest < ActiveSupport::TestCase

  test "client attributes must not be empty" do
    client = Client.new

    assert client.invalid?
    assert client.errors[:name].any?
    assert client.errors[:user_id].any?
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
