require "test_helper"
include AuthenticationHelper

class ClientsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = users(:darlene)
    login_as(@user)
    @client = clients(:ecorp)
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
    session[:user_id] = @user.id

    post "/clients", params: {
      client: {
        name: "New Client",
        hours_worked: 5,
        amount_billed: 300
      }
    }

    expected_client_count = previous_client_count + 1
    assert_equal Client.count, expected_client_count
    client = Client.last
    assert_equal client.name, "New Client"
    assert_equal client.hours_worked, 5
    assert_equal client.amount_billed, 300
    assert_equal client.user_id, @user.id
    assert_equal client.rate, 60

    assert_redirected_to "/clients/#{client.id}"
  end

  test "should show client" do

    get "/clients/#{@client.id}"

    assert_response :success
    assert_select 'h1', "#{@client.name}"
    assert_includes response.body, "#{@client.hours_worked}"
    assert_includes response.body, "#{@client.amount_billed}"
    assert_includes response.body, "#{@client.rate}"
  end

  test "should get edit" do 

    get "/clients/#{@client.id}/edit"

    assert_response :success
    assert_select 'h1', 'Edit client'
    assert_select 'label', "Name"
    assert_select 'label', "Hours worked"
    assert_select 'label', "Amount billed"
  end

end