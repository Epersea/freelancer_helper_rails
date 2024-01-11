class RateCalculator

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
    rate = Rate.find(id)
    rate.rate = 1000000
    rate.save
  end
end
