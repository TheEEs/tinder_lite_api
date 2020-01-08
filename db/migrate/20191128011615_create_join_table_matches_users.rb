class CreateJoinTableMatchesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :matches, :users do |t|
      t.references :match, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
