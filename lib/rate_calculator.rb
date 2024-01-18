require_relative 'rate_calculator/hours'
require_relative 'rate_calculator/expenses'

class RateCalculator
  
  def initialize(user_info, id)
    @expenses = Expenses.new(user_info["expenses"])
    @hours = Hours.new(user_info["hours"])
    @earnings = user_info["earnings"]
    @id = id
  end

  def update
    rate = Rate.find(@id)

    store_data(rate)
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
    rate: hourly_rate
  }
  end

  def total_annual_expenses
    @expenses.total_annual_expenses
  end

  def hours_per_year
    @hours.hours_per_year
  end

  def gross_year
    net_year = net_month * 12
    net_percent = 100 - tax_percent
    gross_minus_expenses = (net_year * 100) / net_percent
    gross_with_expenses = gross_minus_expenses + total_annual_expenses

    gross_with_expenses
  end

  def hourly_rate
    (gross_year / hours_per_year).round(1)
  end

  private

  def store_data(rate)
    rate.annual_expenses = total_annual_expenses
    rate.hours_day = hours_day
    rate.billable_percent = billable_percent
    rate.hours_year = hours_per_year
    rate.net_month = net_month
    rate.tax_percent = tax_percent
    rate.gross_year = gross_year
    rate.rate = hourly_rate
    rate.save
  end

  def hours_day
    @hours.hours_day
  end

  def billable_percent
    @hours.billable_percent
  end

  def net_month
    @earnings["net_monthly_salary"].to_i
  end

  def tax_percent
    @earnings["tax_percent"].to_i
  end
end
