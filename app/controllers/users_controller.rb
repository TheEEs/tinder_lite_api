require "#{Rails.root}/lib/auth0_management_api"
require "#{Rails.root}/lib/FCM"
class UsersController < ApplicationController
  include Secured
  before_action :set_user, only: [:index, :show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where.not(id: @user.id).where.not(:id => Like.where(likeable_type: "User",liker_id: @user.id).pluck(:likeable_id))
    #@users = User.joins("LEFT OUTER JOIN likes ON likes.likeable_id == users.id")\
    #.where('"likes"."liker_id" IS NULL OR "likes"."liker_id" != ?',@user.id).
    #where.not(users:{:id => @user.id}).limit(50).distinct
    #where.not(users:{id: @user.id}).limit(50).distinct  
  end

  # GET /user
  # GET /user
  def show
    @user = User.find_by_identifier(current_user.id)
    if @user.nil?
      render :json => {:message => "Could not found user"}, :status => :not_found
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params_create)
    @user.identifier = current_user.id
    if @user.save
      Auth0ManagementAPI.assign_roles_to_user current_user.id
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params_update)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    Auth0ManagementAPI.delete_user current_user.id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_identifier(current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params_create
      params.require(:user).permit(:avatar, :date_of_birdth, :gender, :intro,:name)
    end

    def user_params_update 
      if params[:user][:avatar] != "false"
        params.require(:user).permit(:avatar,:date_of_birdth,:intro,:name)
      else 
        params.require(:user).permit(:date_of_birdth,:intro,:name)
      end
    end
end
