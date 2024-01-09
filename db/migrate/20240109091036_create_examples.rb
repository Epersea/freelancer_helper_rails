class CreateExamples < ActiveRecord::Migration[7.1]
  def change
    create_table :examples do |t|
      t.integer :col1
      t.integer :col2
      t.integer :col3

      t.timestamps
    end
  end
end
