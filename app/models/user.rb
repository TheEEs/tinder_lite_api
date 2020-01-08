class User < ApplicationRecord
    has_and_belongs_to_many :matches#, table: :users_matches
    acts_as_liker
    acts_as_likeable
    mount_uploader :avatar, AvatarUploader
    has_many :device_tokens, :dependent => :destroy
end
