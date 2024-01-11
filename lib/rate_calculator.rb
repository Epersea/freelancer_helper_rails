class RateCalculator

  def initialize(user_info)
    @user_info = user_info
  end

  def do
    rate = Rate.new
    rate.save

    rate.id
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

  def edit_annual(id)
    rate = Rate.find(id)
    rate.rate = 1000000
    rate.save
  end
end
