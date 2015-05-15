class AddUniqueToPrimerCode < ActiveRecord::Migration
  def change
    add_index :primers, :code, unique: true
  end
end
