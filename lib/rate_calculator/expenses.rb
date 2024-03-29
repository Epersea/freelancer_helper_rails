class Expenses
  def initialize(expenses)
    @long_term_expenses = expenses["long_term"]
    @annual_expenses = expenses["annual"].to_i
    @monthly_expenses = expenses["monthly"].to_i
  end

  def total_annual_expenses
    long_term_per_year + monthly_per_year + @annual_expenses
  end

  private

  def long_term_per_year
    long_term_per_year = 0
    
    @long_term_expenses.each do |expense|
      annual_impact = calculate_annual_impact(expense)
      long_term_per_year += annual_impact
    end

    long_term_per_year
  end

  def calculate_annual_impact(expense)
    begin
      annual_impact = expense["amount"].to_i / expense["years"].to_i
    rescue ZeroDivisionError
      annual_impact = 0
    end
  end

  def monthly_per_year
    @monthly_expenses * 12
  end
end