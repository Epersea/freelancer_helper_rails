class AddColumsToRateInput < ActiveRecord::Migration[7.1]
  def change
    add_column :rate_inputs, :expenses, :jsonb
    add_column :rate_inputs, :hours, :jsonb
    add_column :rate_inputs, :earnings, :jsonb
  end
end
