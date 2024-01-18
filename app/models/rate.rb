class Rate < ApplicationRecord
  validates :rate, :annual_expenses, :hours_day, :hours_year, :billable_percent, :net_month, :tax_percent, :gross_year, presence: true
  validates :rate, :annual_expenses, :hours_day, :hours_year, :billable_percent, :net_month, :tax_percent, :gross_year, numericality: true
end
