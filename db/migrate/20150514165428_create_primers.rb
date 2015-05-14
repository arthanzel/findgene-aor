class CreatePrimers < ActiveRecord::Migration
  def change
    create_table :primers do |t|
      t.string :name
      t.string :code
      t.string :sequence
      t.text :notes

      t.timestamps null: false
    end
  end
end
