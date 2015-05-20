class AddUserToAccess < ActiveRecord::Migration
  def change
    add_reference :accesses, :user, index: true, foreign_key: true
  end
end
