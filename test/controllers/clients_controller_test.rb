require "test_helper"

class ClientsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @darlene = users(:darlene)
    @elliot = users(:elliot)
    @e_corp = clients(:ecorp)
    @f_corp = clients(:fcorp)
    @ten = clients(:client_with_10_rate)
    
    login_as(@darlene)
  end

  test "should get index" do

    get clients_path

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
    assert_select 'p', 'If you want to see more information about your rates and clients, please visit My Summary'
  end

  test "should get new" do
    
    get new_client_path

    assert_response :success
    assert_select 'h1', 'New client'
    assert_select 'label', 'Name'
  end

  test "should create client" do
    previous_client_count = Client.count

    post clients_path, params: {
      client: {
        name: "New Client"
      }
    }

    expected_client_count = previous_client_count + 1
    assert_equal expected_client_count, Client.count
    client = Client.last
    assert_equal "New Client", client.name
    assert_equal 0, client.hours_worked
    assert_equal 0, client.amount_billed
    assert_equal @darlene.id, client.user_id
    assert_equal 0, client.rate

    assert_redirected_to client_path(client)
  end

  test "should not let the user create a client with the same name" do
    post clients_path, params: {
      client: {
        name: "#{@e_corp.name}"
      }
    }

    assert_redirected_to edit_client_path(@e_corp)
    follow_redirect!
    assert_select 'p', "Looks like you have created this client already. Try editing it here!"
  end

  test "should let the user create a client with the same name as another user's client" do
    login_as(@elliot)
    previous_client_count = Client.count

    post clients_path, params: {
      client: {
        name: "#{@e_corp.name}"
      }
    }

    expected_client_count = previous_client_count + 1
    assert_equal expected_client_count, Client.count
    client = Client.last
    assert_equal "#{@e_corp.name}", client.name
    assert_equal @elliot.id, client.user_id
  end

  test "should show client" do

    get client_path(@e_corp)

    assert_response :success
    assert_select 'h3', "#{@e_corp.name}"
    assert_includes response.body, "#{@e_corp.hours_worked}"
    assert_includes response.body, "#{@e_corp.amount_billed}"
    assert_includes response.body, "#{@e_corp.rate}"
  end

  test "should get edit" do 

    get edit_client_path(@e_corp)

    assert_response :success
    assert_select 'h1', 'Edit client'
    assert_select 'label', "Name"
  end

  test "should update client" do

    patch client_path(@e_corp), params: {
      client: {
        name: "Updated client"
      }
    }

    updated_client = Client.find(@e_corp.id)
    assert_equal "Updated client", updated_client.name
    assert_equal @e_corp.hours_worked, updated_client.hours_worked
    assert_equal @e_corp.amount_billed, updated_client.amount_billed
    assert_equal @e_corp.rate, updated_client.rate

    assert_redirected_to client_path(@e_corp)
  end

  test "should destroy client" do
    previous_client_count = Client.count

    delete client_path(@e_corp)

    expected_client_count = previous_client_count - 1
    assert_equal expected_client_count, Client.count

    assert_redirected_to clients_path
    follow_redirect!
    assert_select 'p', "Client #{@e_corp.name} was successfully deleted"
  end

end