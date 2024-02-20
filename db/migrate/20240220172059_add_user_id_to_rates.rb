class AddUserIdToRates < ActiveRecord::Migration[7.1]
  def change
    add_column :rates, :user_id, :integer
  end
end
