class DropRateCalculator < ActiveRecord::Migration[7.1]
  def change
    drop_table :rate_calculators
  end
end
