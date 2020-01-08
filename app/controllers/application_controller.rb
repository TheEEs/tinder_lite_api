class ApplicationController < ActionController::API
    include Secured
    def current_user
        Struct.new(:id,:permissions).new(@user_id,@permissions)
    end
end
