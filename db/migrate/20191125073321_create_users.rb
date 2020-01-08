class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :identifier
      t.string :avatar
      t.date :date_of_birdth
      t.boolean :gender
      t.text :intro

      t.timestamps
    end
    add_index :users, :identifier, unique: true
  end
end
