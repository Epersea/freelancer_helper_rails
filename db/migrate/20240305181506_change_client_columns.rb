class ChangeClientColumns < ActiveRecord::Migration[7.1]
  def change
    change_column :clients, :hours_worked, :decimal, precision: 10, scale: 2
    change_column :clients, :amount_billed, :decimal, precision: 10, scale: 2
    change_column :clients, :rate, :decimal, precision: 10, scale: 2
  end
end
