class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def invite
  	@friendship = Friendship.add_friend(current_user.id, params[:friend_id], "pending")

  	if @friendship.save
  		flash[:notice] = "Request Sent"
  		redirect_to users_path
  	end

  end
end
