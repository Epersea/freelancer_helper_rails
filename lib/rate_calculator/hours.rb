class Hours
  def initialize(hours)
    @hours_day = hours["hours_day"].to_f
    @non_billable = hours["non_billable"].to_i
    @days_week = hours["days_week"].to_i
    @holidays = hours["holidays"].to_i
    @training_days = hours["training"].to_i
    @sick_days = hours["sick"].to_i
  end

  def hours_day
    @hours_day
  end

  def billable_percent
    billable_percent = 100 - @non_billable

    billable_percent
  end

  def hours_per_year
    (days_per_year * net_hours_day).round(1)
  end

  private

  def days_per_year
    working_days = @days_week * 52
    days_off = @holidays + @training_days + @sick_days
    days_per_year = working_days - days_off

    days_per_year
  end

  def net_hours_day
    (@hours_day * billable_percent) / 100
  end
end