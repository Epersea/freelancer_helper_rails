require "test_helper"

class RatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rate = rates(:one)
  end

  test "should get index" do
    get "/"
    assert_response :success
    assert_select 'h1', 'Welcome to Freelancer Helper'
    assert_select 'h2', 'Get organized, work less, and earn more'
    assert_select 'p', minimum: 4
  end

  test "should get new" do
    get "/rate"
    assert_response :success
    assert_select 'h1', 'Rate Calculator'
    assert_select 'form', 1
  end

  test "should create rate" do
    assert_difference("Rate.count") do
      post "/rate", params: { 
        "authenticity_token"=>"nRRrk-21js2N6e2G47cWw3sMNs9qDs2bFZMdntDsk7v1iMy8qwHjXXW8Yv-6a1nbPxQk476rBUQu0eRguh7E1g",
        "expenses"=>
          {"long_term"=>[
            {"amount"=>"1000",
            "years"=>"10"},
            {"amount"=>"500",
            "years"=>"5"},
            {"amount"=>"555",
            "years"=>"5"},
            {"amount"=>"",
            "years"=>""}
          ],
          "annual"=>"1000",
          "monthly"=>"100"
          },
        "hours"=>{
          "hours_day"=>"5",
          "non_billable"=>"20",
          "days_week"=>"5",
          "holidays"=>"25",
          "training"=>"5",
          "sick"=>"5"
        },
        "earnings"=>{
          "net_monthly_salary"=>"2200",
          "tax_percent"=>"20"
        },
        "commit"=>"Calculate",
        "controller"=>"rate",
        "action"=>"create"
    }
  end

    rate_id = Rate.last.id
    assert_redirected_to "/rate/#{rate_id}"
  end

  # test "should show rate" do
  #   get rate_url(@rate)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_rate_url(@rate)
  #   assert_response :success
  # end

  # test "should update rate" do
  #   patch rate_url(@rate), params: { rate: {  } }
  #   assert_redirected_to rate_url(@rate)
  # end

  # test "should destroy rate" do
  #   assert_difference("Rate.count", -1) do
  #     delete rate_url(@rate)
  #   end

  #   assert_redirected_to rates_url
  # end
end
