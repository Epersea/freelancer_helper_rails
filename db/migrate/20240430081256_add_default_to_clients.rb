class AddDefaultToClients < ActiveRecord::Migration[7.1]
  def change
    change_column_default :clients, :hours_worked, 0
    change_column_default :clients, :amount_billed, 0
    change_column_default :clients, :rate, 0
  end
end
