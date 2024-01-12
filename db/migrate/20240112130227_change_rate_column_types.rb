class ChangeRateColumnTypes < ActiveRecord::Migration[7.1]
  def change
    change_column :rates, :hours_day, :integer
    change_column :rates, :billable_percent, :integer
    change_column :rates, :net_month, :integer
    change_column :rates, :gross_year, :integer
  end
end
