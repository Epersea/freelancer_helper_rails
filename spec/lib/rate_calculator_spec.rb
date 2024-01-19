require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  let(:rate_calculator) {RateCalculator.new(user_info)}
  let(:annual_expenses) { 5250 }
  let(:hours_year) { 1070.4 }
  let(:gross_year) { 45250 }
  let(:goal_rate) { 42.3 }


  describe 'Hours' do
    it 'calculates total billable hours per year' do

      hours_per_year = rate_calculator.hours_per_year

      expect(hours_per_year).to eq(hours_year)
    end
  end

  describe 'Earnings' do
    it 'calculates gross earnings per year' do

      gross_earnings_year = rate_calculator.gross_year

      expect(gross_earnings_year).to eq(gross_year)
    end
  end

  describe 'Goal rate' do
    it 'calculates final goal rate' do
      
      hourly_rate = rate_calculator.hourly_rate

      expect(hourly_rate).to eq(goal_rate)
    end
  end

  describe 'Aggregated info' do
    it 'returns aggregated info in the correct format' do

      aggregated_info = rate_calculator.do

      expect(aggregated_info).to eq(rate_info)
    end
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

  def rate_info 
    {
      rate: goal_rate,
      annual_expenses: annual_expenses,
      hours_day: 6,
      hours_year: hours_year,
      billable_percent: 80,
      net_month: 2500,
      tax_percent: 25,
      gross_year: gross_year
    }
  end
end