class Rate < ApplicationRecord
  validates :rate, :annual_expenses, :hours_day, :hours_year, :billable_percent, :net_month, :tax_percent, :gross_year, presence: true
  validates :rate, :annual_expenses, :hours_day, :billable_percent, :tax_percent, :gross_year, numericality: true
  validates :hours_year, :net_month, numericality: { greater_than_or_equal_to: 1 }
end
