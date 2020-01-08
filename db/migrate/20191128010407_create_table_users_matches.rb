class CreateTableUsersMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :table_users_matches do |t|
      t.references :user, foreign_key: true
      t.references :match, foreign_key: true
    end
  end
end
