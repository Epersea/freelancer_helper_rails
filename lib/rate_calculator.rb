class RateCalculator

  def initialize(user_info)
    @user_info = user_info
  end

  def do
    rate = Rate.new
    rate.annual_expenses = total_annual_expenses
    rate.hours_day = hours_day
    rate.billable_percent = billable_percent
    rate.save

    rate.id
  end

  def total_annual_expenses
    long_term_expenses = long_term_per_year
    monthly_expenses = monthly_per_year
    annual_expenses = @user_info["expenses"]["annual"].to_i
    total_annual_expenses = long_term_expenses + monthly_expenses + annual_expenses

    total_annual_expenses
  end

  def long_term_per_year
    long_term_expenses = @user_info["expenses"]["long_term"]
    long_term_per_year = 0
    
    long_term_expenses.each do |expense|
      annual_impact = expense["amount"].to_i / expense["years"].to_i
      long_term_per_year += annual_impact
    end

    long_term_per_year
  end

  def monthly_per_year
    monthly_expenses = @user_info["expenses"]["monthly"]
    monthly_per_year = monthly_expenses.to_i * 12

    monthly_per_year
  end

  def hours_day
    @user_info["hours"]["hours_day"].to_f
  end

  def billable_percent
    percent_non_billable = @user_info["hours"]["non_billable"].to_f
    billable_percent = 100 - percent_non_billable

    billable_percent
  end

  def net_hours_day
    (hours_day * billable_percent) / 100
  end
end
