class RenameExampleToRateCalculator < ActiveRecord::Migration[7.1]
  def change
    rename_table :examples, :rate_calculator
  end
end