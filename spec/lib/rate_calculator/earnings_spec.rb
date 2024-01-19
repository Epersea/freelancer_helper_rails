require 'rails_helper'
require 'rate_calculator'
require 'rate_calculator/earnings'

describe 'Earnings' do
  it 'calculates gross earnings per year' do
    earnings = Earnings.new(earnings_info, annual_expenses)

    gross_earnings_year = earnings.gross_year

    expected_gross_earnings = 45250
    expect(gross_earnings_year).to eq(expected_gross_earnings)
  end

  def earnings_info
    {
      "net_monthly_salary"=>"2500",
      "tax_percent"=>"25"
    }
  end

  def annual_expenses
    5250
  end
end