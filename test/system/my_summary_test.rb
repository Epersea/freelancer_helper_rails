require "application_system_test_case"

class MySummaryTest < ApplicationSystemTestCase

  setup do
    @darlene = users(:darlene)
    @basic_rate = rates(:basic_rate)
    @e_corp = clients(:ecorp)
    @f_corp = clients(:fcorp)
  end

  test "should display user information (rates and clients)" do
    login_as(@darlene)

    assert_text "Darlene, this is your Freelancer Summary"
    assert_text "Rate info"
    assert_text "Your minimum rate per hour should be #{@basic_rate.rate}"
    assert_text "Client info"
    assert_text "All your clients are above your goal rate. Good job! Why not being a bit more ambitious?"
    assert_text "#{@e_corp.name}"
    assert_text "Rate per hour: #{@e_corp.rate}"
    assert_text "#{@f_corp.name}"
    assert_text "Rate per hour: #{@f_corp.rate}"
  end
end