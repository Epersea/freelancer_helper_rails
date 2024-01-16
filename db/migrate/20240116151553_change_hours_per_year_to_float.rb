class ChangeHoursPerYearToFloat < ActiveRecord::Migration[7.1]
  def change
    change_column :rates, :hours_year, :float
  end
end
