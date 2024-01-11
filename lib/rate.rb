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
end
