class RateCalculator

  def initialize(user_info)
    @user_info = user_info
  end

  def do
    rate = Rate.new
    rate.annual_expenses = calculate_total_annual_expenses
    rate.save

    rate.id
  end

  def calculate_total_annual_expenses
    long_term_expenses = calculate_long_term
    monthly_expenses = calculate_monthly
    annual_expenses = @user_info["expenses"]["annual"].to_i
    total_annual_expenses = long_term_expenses + monthly_expenses + annual_expenses

    total_annual_expenses

  end

  def calculate_long_term
    long_term_expenses = @user_info["expenses"]["long_term"]
    long_term_per_year = 0
    
    long_term_expenses.each do |expense|
      annual_impact = expense["amount"].to_i / expense["years"].to_i
      long_term_per_year += annual_impact
    end

    long_term_per_year
  end

  def calculate_monthly
    monthly_expenses = @user_info["expenses"]["monthly"]
    monthly_per_year = monthly_expenses.to_i * 12

    monthly_per_year
  end
end
