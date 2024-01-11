require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  let(:rate_calculator) {RateCalculator.new(user_info)}

  it 'creates a new rate and returns its id' do

    id = rate_calculator.do
    
    expect(id).to be_a(Numeric)
  end

  describe 'Expenses' do
    it 'calculates impact of long-term expenses per year' do

      long_term_expenses_per_year = rate_calculator.long_term_per_year

      expect(long_term_expenses_per_year).to eq(650)
    end

    it 'calculates impact of monthly expenses' do

      monthly_expenses_per_year = rate_calculator.monthly_per_year

      expect(monthly_expenses_per_year).to eq(3600)
    end

    it 'calculates total annual expenses and saves them in rate' do

      id = rate_calculator.do

      rate = Rate.find(id)
      expect(rate.annual_expenses).to eq(5250)
    end

    describe 'Hours' do
      it 'saves hours/day to rate' do
        
        id = rate_calculator.do

        rate = Rate.find(id)
        expect(rate.hours_day).to eq(6)
      end

      it 'saves billable percent to rate' do
        
        id = rate_calculator.do

        rate = Rate.find(id)
        expect(rate.billable_percent).to eq(80)
      end

      it 'calculates net hours per day' do

        hours_per_day = rate_calculator.net_hours_day

        expect(hours_per_day).to eq(4.8)
      end

      it 'calculates days worked per year' do

        days_per_year = rate_calculator.days_per_year

        expect(days_per_year).to eq(223)
      end

      it 'calculates total billable hours and saves them in rate' do
        
        id = rate_calculator.do

        rate = Rate.find(id)
        expect(rate.hours_year).to eq(1070.4)
      end
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