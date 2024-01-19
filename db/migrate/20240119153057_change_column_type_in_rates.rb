class ChangeColumnTypeInRates < ActiveRecord::Migration[7.1]
  def change
    change_column :rates, :user_info, :jsonb, default: {}
  end
end
