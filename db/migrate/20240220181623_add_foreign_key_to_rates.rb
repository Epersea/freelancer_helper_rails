class AddForeignKeyToRates < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :rates, :users, column: :user_id
  end
end
