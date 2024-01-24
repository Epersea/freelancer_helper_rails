class RemoveUserInfoFromRates < ActiveRecord::Migration[7.1]
  def up
    # Store the data you want to keep before removing the column
    add_column :rates, :user_info_backup, :json

    # Update the new column with data from the old column (if needed)
    Rate.all.each do |rate|
      rate.update(user_info_backup: rate.user_info)
    end

    # Remove the old column
    remove_column :rates, :user_info
  end

  def down
    # Restore the original column if you need to rollback the migration
    add_column :rates, :user_info, :json

    # Update the restored column with data from the new column (if needed)
    Rate.all.each do |rate|
      rate.update(user_info: rate.user_info_backup)
    end

    # Remove the temporary column
    remove_column :rates, :user_info_backup
  end
end
