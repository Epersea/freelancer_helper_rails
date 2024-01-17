require 'rails_helper'
require 'rate_calculator'

RSpec.describe RateCalculator do
  let(:rate_calculator) {RateCalculator.new(user_info, any_id)}
  let(:annual_expenses) { 5250 }
  let(:hours_year) { 1070.4 }
  let(:gross_year) { 45250 }
  let(:goal_rate) { 42.3 }

  describe 'Expenses' do
    it 'calculates total annual expenses' do

      total_annual_expenses = rate_calculator.total_annual_expenses

      expect(total_annual_expenses).to eq(annual_expenses)
    end

    it 'skips empty long-term expenses' do
      rate_calculator_with_empty_expenses = RateCalculator.new(user_info_with_empty_expenses, any_id)

      long_term_expenses_per_year = rate_calculator_with_empty_expenses.total_annual_expenses

      expected_annual_expenses = 5000
      expect(long_term_expenses_per_year).to eq(expected_annual_expenses)
    end
  end

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

  describe 'Rate model' do
    it 'saves form inputs and calculations in Rate' do
      create_rate_with_any_id

      rate_calculator.do

      rate = Rate.find(any_id)
      hours_day = 6
      billable_percent = 80
      net_month = 2500
      tax_percent = 25
      expect(rate.annual_expenses).to eq(annual_expenses)
      expect(rate.hours_day).to eq(hours_day)
      expect(rate.billable_percent).to eq(billable_percent)
      expect(rate.hours_year).to eq(hours_year)
      expect(rate.net_month).to eq(net_month)
      expect(rate.tax_percent).to eq(tax_percent)
      expect(rate.gross_year).to eq(gross_year)
      expect(rate.rate).to eq(goal_rate)
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

  def user_info_with_empty_expenses
    {
      "expenses"=>{
        "long_term"=>[
            {"amount"=>"1500",
              "years"=>"5"},
            {"amount"=>"0",
              "years"=>"0"},
            {"amount"=>"0",
              "years"=>"0"},
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

  def any_id
    117
  end

  def create_rate_with_any_id
    new_rate = Rate.new
    new_rate.id = any_id
    new_rate.save
  end
end