class Earnings
  def initialize(earnings, annual_expenses)
    @earnings = earnings
    @annual_expenses = annual_expenses
  end

  def gross_year
    net_year = @earnings["net_monthly_salary"].to_i * 12
    net_percent = 100 - @earnings["tax_percent"].to_i
    gross_minus_expenses = (net_year * 100) / net_percent
    gross_with_expenses = gross_minus_expenses + @annual_expenses

    gross_with_expenses
  end
end