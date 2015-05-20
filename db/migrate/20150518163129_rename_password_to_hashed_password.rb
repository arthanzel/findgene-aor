class RenamePasswordToHashedPassword < ActiveRecord::Migration
  def change
    rename_column :users, :password, :password_hash
    remove_column :users, :salt
  end
end
