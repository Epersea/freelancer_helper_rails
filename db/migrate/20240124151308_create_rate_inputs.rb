class CreateRateInputs < ActiveRecord::Migration[7.1]
  def change
    drop_table :rate_inputs

    create_table :rate_inputs do |t|
      t.references :rate, null: false, foreign_key: true

      t.timestamps
    end
  end
end
