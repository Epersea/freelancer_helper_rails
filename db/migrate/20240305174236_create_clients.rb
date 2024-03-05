class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.references :user, null: false, foreign_key: true
      t.string :client_name
      t.integer :hours_worked
      t.integer :amount_billed
      t.float :rate

      t.timestamps
    end
  end
end
