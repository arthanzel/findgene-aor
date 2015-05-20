class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :salt
      t.references :access, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
