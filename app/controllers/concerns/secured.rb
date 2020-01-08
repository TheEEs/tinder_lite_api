# app/controllers/concerns/secured.rb
require_relative "#{Rails.root}/lib/json_web_token"
# frozen_string_literal: true
module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  private

  # app/controllers/concerns/secured.rb


  private

  def authenticate_request!
    @auth_payload, @auth_header = auth_token
    @user_id = @auth_payload['sub']
    @permissions = @auth_payload['permissions']
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def scope_included
    if SCOPES[request.env['PATH_INFO']] == nil
      true
    else
      # The intersection of the scopes included in the given JWT and the ones in the SCOPES hash needed to access
      # the PATH_INFO, should contain at least one element
      (String(@auth_payload['scope']).split(' ') & (SCOPES[request.env['PATH_INFO']])).any?
    end
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end
end