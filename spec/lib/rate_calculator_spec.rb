require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  let(:rate_calculator) {RateCalculator.new(user_info)}

  it 'returns aggregated info in the correct format' do
    rate = Rate.new

    aggregated_info = rate_calculator.apply_to(rate)

    expect(rate.rate).to eq(expected_rate_info[:rate])
    expect(rate.annual_expenses).to eq(expected_rate_info[:annual_expenses])
    expect(rate.hours_day).to eq(expected_rate_info[:hours_day])
    expect(rate.hours_year).to eq(expected_rate_info[:hours_year])
    expect(rate.billable_percent).to eq(expected_rate_info[:billable_percent])
    expect(rate.net_month).to eq(expected_rate_info[:net_month])
    expect(rate.tax_percent).to eq(expected_rate_info[:tax_percent])
    expect(rate.gross_year).to eq(expected_rate_info[:gross_year])
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
          "net_month"=>"2500",
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