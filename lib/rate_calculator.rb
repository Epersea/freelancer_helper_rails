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
    total_user_info = 0
    
    @user_info.each do |expense|
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
