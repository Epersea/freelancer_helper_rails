class CreateRates < ActiveRecord::Migration[7.1]
  def change
    create_table :rates do |t|
      t.float :rate
      t.float :annual_expenses
      t.float :hours_day
      t.float :hours_year
      t.float :billable_percent
      t.float :net_month
      t.float :tax_percent
      t.float :gross_year

      t.timestamps
    end
  end
end
