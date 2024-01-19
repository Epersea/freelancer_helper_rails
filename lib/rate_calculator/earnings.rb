class Earnings
  def initialize(earnings, annual_expenses)
    @earnings = earnings
    @annual_expenses = annual_expenses
  end

  def net_month
    @earnings["net_monthly_salary"].to_i
  end

  def tax_percent
    @earnings["tax_percent"].to_i
  end

  def gross_year
    net_year = net_month * 12
    net_percent = 100 - tax_percent
    gross_minus_expenses = (net_year * 100) / net_percent
    gross_with_expenses = gross_minus_expenses + @annual_expenses

    gross_with_expenses
  end
end