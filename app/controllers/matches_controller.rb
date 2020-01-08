class MatchesController < ApplicationController
  include Secured
  before_action :set_current_user

  # GET /matches
  # GET /matches.json
  def index
    @matches = @user.matches
  end

  def show
    @match = Match.find(params[:id])
    if !(@match.users.pluck(:id).include? @user.id)
      render :json => {}, status: :forbidden
    end
  end

  # POST /matches
  # POST /matches.json

  # DELETE /matches/1
  # DELETE /matches/1.json
  def destroy
    match_id = params[:id]
    @match = Match.find(match_id)
    if @match.users.pluck(:id).include? @user.id 
      @match.destroy 
      render json: {},:status => :no_content
    else 
      render json: {},:status => :forbidden
    end
  end

  private 
  def set_current_user
    @user = User.find_by_identifier(current_user.id)
  end
end
