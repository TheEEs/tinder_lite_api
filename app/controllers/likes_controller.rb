require "#{Rails.root}/lib/FCM"
class LikesController < ApplicationController
  include Secured
  def index
    
  end

  def create
    me = User.find_by_identifier(current_user.id)
    that_user = User.find_by_identifier(params[:id]) 
    if me && that_user
      me.like! that_user
      if that_user.likes? me then 
        new_match = Match.new 
        if new_match.save 
          new_match.users.push me,that_user
          render :json => {
            :match => new_match.id
          }, status: :created
          return Push.notice_clients me.device_tokens.pluck(:token) + that_user.device_tokens.pluck(:token), {
            "notification":{
              "title": "TinderLite",
              "body": "You have new match, check it out ;-)"
            }
          }
        end
      end
      render :json => {}, status: :no_content
    else
      render :json => {
        errors: [
          "can not find users that according to provided id"
        ]
      }, status: :not_found
    end
  end
end
