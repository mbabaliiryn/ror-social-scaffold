class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @pending_friends = @user.pending_friends
    # @my_friends = @user.my_friends
    @friend_requests = @user.friend_requests
  end

  def invite
  	@friendship = Friendship.add_friend(current_user.id, params[:friend_id], "pending")

  	if @friendship.save
  		flash[:notice] = "Request Sent"
  		redirect_to users_path
  	else
  		flash[:alert] = "Friend request already sent!"
  		redirect_to users_path
  	end

  end

  def accept
  	@friendship = Friendship.find_by(friend_id: params[:id])
  	# byebug
  	friendship_params = params.require(:friendship).permit(:state)
  	if @friendship.update(friendship_params)  	
  		redirect_to users_path, notice: "Status Successfully Changed"
  	end
  end

  
end
