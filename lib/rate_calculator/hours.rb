class Hours
  def initialize(hours)
    @hours = hours
  end

  def hours_day
    @hours["hours_day"].to_f
  end

  def billable_percent
    percent_non_billable = @hours["non_billable"].to_i
    billable_percent = 100 - percent_non_billable

    billable_percent
  end

  def hours_per_year
    (days_per_year * net_hours_day).round(1)
  end

  private

  def days_per_year
    working_days = calculate_working_days
    days_off = calculate_days_off
    days_per_year = working_days - days_off

    days_per_year
  end

  def calculate_working_days
    days_week = @hours["days_week"].to_i
    working_days = days_week * 52

    working_days
  end

  def calculate_days_off
    holidays = @hours["holidays"].to_i
    training_days = @hours["training"].to_i
    sick_days = @hours["sick"].to_i
    days_off = holidays + training_days + sick_days

    days_off
  end

  def net_hours_day
    (hours_day * billable_percent) / 100
  end
end