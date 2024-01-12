class Expenses
  def initialize(expenses)
    @expenses = expenses
  end

  def total_annual_expenses
    long_term_expenses = long_term_per_year
    monthly_expenses = monthly_per_year
    annual_expenses = @expenses["annual"].to_i
    total_annual_expenses = long_term_expenses + monthly_expenses + annual_expenses

    total_annual_expenses
  end

  def long_term_per_year
    long_term_expenses = @expenses["long_term"]
    long_term_per_year = 0
    
    long_term_expenses.each do |expense|
      begin
        annual_impact = expense["amount"].to_i / expense["years"].to_i
      rescue ZeroDivisionError
        annual_impact = 0
      end
      long_term_per_year += annual_impact
    end

    long_term_per_year
  end

  def monthly_per_year
    monthly_expenses = @expenses["monthly"]
    monthly_per_year = monthly_expenses.to_i * 12

    monthly_per_year
  end
end