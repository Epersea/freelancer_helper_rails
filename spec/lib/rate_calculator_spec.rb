require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  it 'creates a new rate and returns its id' do
    rate_calculator = RateCalculator.new(user_info)

    id = rate_calculator.do
    
    expect(id).to be_a(Numeric)
  end

  describe 'Expenses' do
    it 'calculates impact of long-term expenses per year' do
      rate_calculator = RateCalculator.new(user_info)

      long_term_expenses_per_year = rate_calculator.calculate_long_term

      expect(long_term_expenses_per_year).to eq(650)
    end

    it 'calculates impact of monthly expenses' do
      rate_calculator = RateCalculator.new(user_info)

      monthly_expenses_per_year = rate_calculator.calculate_monthly

      expect(monthly_expenses_per_year).to eq(3600)
    end

    it 'calculates total annual expenses and saves them in rate' do
      rate_calculator = RateCalculator.new(user_info)

      id = rate_calculator.do

      rate = Rate.find(id)
      expect(rate.annual_expenses).to eq(5250)
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
        "net_monthly_salary"=>"2500",
        "tax_percent"=>"25"
    }
  end
end