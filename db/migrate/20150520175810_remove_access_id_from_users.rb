class RemoveAccessIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :access_id
  end
end
