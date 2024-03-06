require "test_helper"
include AuthenticationHelper

class ClientsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:darlene)
    login_as(@user)
  end

  test "should get new" do
    
    get "/clients/new"

    assert_response :success
    assert_select 'h1', 'New client'
    assert_select 'label', 'Name'
    assert_select 'label', 'Hours worked'
    assert_select 'label', 'Amount billed'
  end

  test "should create client" do
    previous_client_count = Client.count

    post "/client", params: {
      name: "New Client",
      hours_worked: 5,
      amount_billed: 300,
      user_id: @user.id
    }

    expected_client_count = previous_client_count + 1
    assert_equal Client.count, expected_client_count
    client = Client.last
    assert_equal client.name, "New Client"
    assert_equal client.hours_worked, 5
    assert_equal client.amount_billed, 300
    assert_equal client.user_id, @user.id
    assert_equal client.rate, 60

    assert_redirected_to "/client/#{client.id}"
  end

end