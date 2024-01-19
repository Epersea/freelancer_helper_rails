require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  let(:rate_calculator) {RateCalculator.new(user_info)}

  it 'returns aggregated info in the correct format' do

    aggregated_info = rate_calculator.do

    expect(aggregated_info).to eq(expected_rate_info)
  end
 
  def user_info
    {
      "expenses"=>{
        "long_term"=>[
            {"amount"=>"1500",
              "years"=>"5"},
            {"amount"=>"800",
              "years"=>"4"},
            {"amount"=>"300",
              "years"=>"6"},
            {"amount"=>"1000",
              "years"=>"10"}
            ],
          "annual"=>"1000",
          "monthly"=>"300"
        },
        "hours"=>{
          "hours_day"=>"6",
          "non_billable"=>"20",
          "days_week"=>"5",
          "holidays"=>"25",
          "training"=>"6",
          "sick"=>"6"
        },
        "earnings"=> {
          "net_monthly_salary"=>"2500",
          "tax_percent"=>"25"
        }
    }
  end

  def expected_rate_info 
    {
      rate: 42.3,
      annual_expenses: 5250,
      hours_day: 6,
      hours_year: 1070.4,
      billable_percent: 80,
      net_month: 2500,
      tax_percent: 25,
      gross_year: 45250
    }
  end
end