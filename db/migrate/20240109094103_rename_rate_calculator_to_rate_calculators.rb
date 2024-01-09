class RenameRateCalculatorToRateCalculators < ActiveRecord::Migration[7.1]
  def change
    rename_table :rate_calculator, :rate_calculators
  end
end
