class Match < ApplicationRecord
    has_and_belongs_to_many :users #, table: :users_matches
end
