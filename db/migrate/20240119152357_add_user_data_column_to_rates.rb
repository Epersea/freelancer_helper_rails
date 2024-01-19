class AddUserDataColumnToRates < ActiveRecord::Migration[7.1]
  def change
    add_column :rates, :user_info, :text
  end
end
