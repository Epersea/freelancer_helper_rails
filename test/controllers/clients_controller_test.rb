require "test_helper"
include AuthenticationHelper

class ClientsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @darlene = users(:darlene)
    @elliot = users(:elliot)
    @e_corp = clients(:ecorp)
    @f_corp = clients(:fcorp)
    
    login_as(@darlene)
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
    assert_equal client.user_id, @darlene.id
    assert_equal client.rate, 60

    assert_redirected_to "/clients/#{client.id}"
  end

  test "should not let the user create a client with the same name" do
    post "/clients", params: {
      client: {
        name: "#{@e_corp.name}",
        hours_worked: 5,
        amount_billed: 300
      }
    }

    assert_redirected_to "/clients/#{@e_corp.id}/edit"
    follow_redirect!
    assert_select 'p', "Looks like you have created this client already. Try editing it here!"
  end

  test "should let the user create a client with the same name as another users client" do
    login_as(@elliot)
    previous_client_count = Client.count

    post "/clients", params: {
      client: {
        name: "#{@e_corp.name}",
        hours_worked: 5,
        amount_billed: 300
      }
    }

    expected_client_count = previous_client_count + 1
    assert_equal Client.count, expected_client_count
    client = Client.last
    assert_equal client.name, "#{@e_corp.name}"
    assert_equal client.hours_worked, 5
    assert_equal client.amount_billed, 300
    assert_equal client.user_id, @elliot.id
    assert_equal client.rate, 60
  end

  test "should show client" do

    get "/clients/#{@e_corp.id}"

    assert_response :success
    assert_select 'h3', "#{@e_corp.name}"
    assert_includes response.body, "#{@e_corp.hours_worked}"
    assert_includes response.body, "#{@e_corp.amount_billed}"
    assert_includes response.body, "#{@e_corp.rate}"
  end

  test "should get edit" do 

    get "/clients/#{@e_corp.id}/edit"

    assert_response :success
    assert_select 'h1', 'Edit client'
    assert_select 'label', "Name"
    assert_select 'label', "Hours worked"
    assert_select 'label', "Amount billed"
  end

  test "should update client" do

    patch "/clients/#{@e_corp.id}", params: {
      client: {
        name: "Updated client",
        hours_worked: 12,
        amount_billed: 2400
      }
    }

    updated_client = Client.find(@e_corp.id)
    assert_equal updated_client.name, "Updated client"
    assert_equal updated_client.hours_worked, 12
    assert_equal updated_client.amount_billed, 2400
    assert_equal updated_client.rate, 200

    assert_redirected_to "/clients/#{@e_corp.id}"
  end

  test "should destroy client" do
    previous_client_count = Client.count

    delete "/clients/#{@e_corp.id}"

    expected_client_count = previous_client_count - 1
    assert_equal Client.count, expected_client_count

    assert_redirected_to clients_path
    follow_redirect!
    assert_select 'p', "Client #{@e_corp.name} was successfully deleted"
  end

  test "should get index" do

    get "/clients"

    assert_response :success
    assert_select 'h1', "#{@darlene.name}'s clients"
    assert_select 'h3', "#{@e_corp.name}"
    assert_includes response.body, "#{@e_corp.hours_worked}"
    assert_includes response.body, "#{@e_corp.amount_billed}"
    assert_includes response.body, "#{@e_corp.rate}"
    assert_select 'h3', "#{@f_corp.name}"
    assert_includes response.body, "#{@f_corp.hours_worked}"
    assert_includes response.body, "#{@f_corp.amount_billed}"
    assert_includes response.body, "#{@f_corp.rate}"
    assert_select 'p', 'If you want to see more information about your rates and clients, please visit'
  end

end