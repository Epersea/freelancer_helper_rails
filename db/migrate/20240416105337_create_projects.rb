class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.references :client, null: false, foreign_key: true
      t.string :name
      t.float :hours_worked
      t.float :amount_billed
      t.float :rate
      t.text :description

      t.timestamps
    end
  end
end
