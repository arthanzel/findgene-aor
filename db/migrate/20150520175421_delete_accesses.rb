class DeleteAccesses < ActiveRecord::Migration
  def change
    drop_table :accesses
  end
end
