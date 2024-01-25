class Earnings
  def initialize(earnings, annual_expenses)
    @net_month = earnings["net_month"].to_i
    @tax_percent = earnings["tax_percent"].to_i
    @annual_expenses = annual_expenses
  end

  def net_month
    @net_month
  end

  def tax_percent
    @tax_percent
  end

  def gross_year
    gross_minus_expenses + @annual_expenses
  end

  def gross_minus_expenses
    (net_year * 100) / net_percent
  end

  def net_year
    @net_month * 12
  end

  def net_percent
    100 - @tax_percent
  end
end