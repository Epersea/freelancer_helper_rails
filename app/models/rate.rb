class Rate < ApplicationRecord
  validates :rate, :annual_expenses, :hours_day, :hours_year, :billable_percent, :net_month, :tax_percent, :gross_year, presence: true
  validates :rate, :annual_expenses, :hours_day, :billable_percent, :tax_percent, :gross_year, numericality: true
  validates :hours_year, :net_month, numericality: { greater_than_or_equal_to: 1 }

  has_one :input, dependent: :destroy

  class << self
    def create_for(**user_input_attributes)
      new.tap do | rate |
        rate.build_input user_input_attributes
        rate.refresh!
      end
    end
  end

  def update_for(**user_input_attributes)
    transaction do
      input.update(user_input_attributes)
      refresh!
    end
  end
  
  def refresh
    rate_calculator = RateCalculator.new(input)
    rate_calculator.apply_to(self)
  end

  def refresh!
    refresh
    save!
  end
end
