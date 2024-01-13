class ChangeRateColumnType < ActiveRecord::Migration[7.1]
  def change
    change_column :rates, :annual_expenses, :integer
    change_column :rates, :hours_year, :integer
  end
end
