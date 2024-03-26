class ChangeColumnTypesInClients < ActiveRecord::Migration[7.1]
  def change
    change_column :clients, :hours_worked, :float
    change_column :clients, :amount_billed, :float
    change_column :clients, :rate, :float
  end
end
