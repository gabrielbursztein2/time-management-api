class RemoveUsernameFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :username, :string, null: false, default: ''
  end
end
