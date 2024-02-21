class AddForeignKeyToRates < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :rates, :users, column: :user_id, optional: true
    add_index :rates, :user_id, unique: true
  end
end
