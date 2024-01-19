require 'rails_helper'
require 'rate_calculator'
require 'rate_calculator/expenses'

describe 'Expenses' do
  it 'calculates total annual expenses' do
    expenses = Expenses.new(standard_expenses)

    total_annual_expenses = expenses.total_annual_expenses

    expected_annual_expenses = 5250
    expect(total_annual_expenses).to eq(expected_annual_expenses)
  end

  it 'skips empty long-term expenses' do
    expenses_with_empty_fields = Expenses.new(expenses_with_empty_long_term)

    total_annual_expenses = expenses_with_empty_fields.total_annual_expenses

    expected_annual_expenses = 5000
    expect(total_annual_expenses).to eq(expected_annual_expenses)
  end

  def standard_expenses
    {
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
    }
  end

  def expenses_with_empty_long_term
    {
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
    }
  end
end