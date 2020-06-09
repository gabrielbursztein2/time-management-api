class AddWorkingHoursToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :working_hours, :integer, null: false, default: 8
  end
end
