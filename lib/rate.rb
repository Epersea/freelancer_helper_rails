class Rate

  def initialize(expenses)
    @expenses = expenses
  end

  def calculate_long_term
    total_expenses = 0
    
    @expenses.each do |expense|
      total_expenses += expense["amount"].to_i
    end

    total_expenses
  end

  def edit_annual(id)
    rate_calculator = RateCalculator.find(id)
    rate_calculator.col2 = 1000000
    rate_calculator.save
  end
end
