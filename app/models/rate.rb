class Rate < ApplicationRecord
  validates :rate, :annual_expenses, :hours_day, :hours_year, :billable_percent, :net_month, :tax_percent, :gross_year, presence: true
  validates :rate, :annual_expenses, :hours_day, :billable_percent, :tax_percent, :gross_year, numericality: true
  validates :hours_year, :net_month, numericality: { greater_than_or_equal_to: 1 }

  has_one :input, dependent: :destroy

  class << self
    def create_for(user_input_attributes)
      rate = new
      rate.build_input user_input_attributes
      rate.refresh
      rate.save!
      rate
    end
  end

  # store :data, accessors: [
  #   "expenses.long_term",
  #   "expenses.annual",
  #   "expenses.monthly",
  #   "hours.hours_day",
  #   "hours.non_billable",
  #   "hours.days_week",
  #   "hours.holidays",
  #   "hours.training",
  #   "hours.sick",
  #   "earnings.net_monthly_salary",
  #   "earnings.tax_percent"
  # ]

  def refresh
    rate_calculator = RateCalculator.new(input)
    rate_calculator.apply_to(self)
  end
end
