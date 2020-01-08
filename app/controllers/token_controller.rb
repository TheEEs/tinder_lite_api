class TokenController < ApplicationController
  include Secured
  #POST /api/token/remove/:token
  def add
    token = params[:token]
    user = User.find_by_identifier(current_user.id)
    if user 
      user.device_tokens.create!(token: token)
      render json: {}, status: :created
    else
      render json:{}, :status => :not_found 
    end
  end
  #DELETE /api/token/add/:token
  def remove
    token = params[:token]
    user = User.find_by_identifier current_user.id 
    if user 
      user.device_tokens.where(token: token).destroy_all 
      render json: {}, status: :no_content 
    else 
      render json: {},status: :bad_request 
    end
  end
end
