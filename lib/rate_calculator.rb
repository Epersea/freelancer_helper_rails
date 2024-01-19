require_relative 'rate_calculator/hours'
require_relative 'rate_calculator/expenses'
require_relative 'rate_calculator/earnings'

class RateCalculator

  def initialize(user_info)
    @expenses = Expenses.new(user_info["expenses"])
    @hours = Hours.new(user_info["hours"])
    @earnings_info = user_info["earnings"]
  end

  def do
  {
    annual_expenses: total_annual_expenses,
    hours_day: hours_day,
    billable_percent: billable_percent,
    hours_year: hours_per_year,
    net_month: net_month,
    tax_percent: tax_percent,
    gross_year: gross_year,
    rate: goal_rate
  }
  end

  def goal_rate
    (gross_year / hours_per_year).round(1)
  end

  private

  def earnings
    Earnings.new(@earnings_info, total_annual_expenses)
  end

  def total_annual_expenses
    @expenses.total_annual_expenses
  end

  def hours_day
    @hours.hours_day
  end

  def billable_percent
    @hours.billable_percent
  end

  def hours_per_year
    @hours.hours_per_year
  end

  def net_month
    earnings.net_month
  end

  def tax_percent
    earnings.tax_percent
  end

  def gross_year
    earnings.gross_year
  end
end
