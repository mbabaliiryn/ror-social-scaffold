class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.ordered_by_most_recent
		@pending_friends = @user.pending_friends
		@my_friends = @user.my_friends
		@friend_requests = @user.friend_requests
  end

  def invite
  	@new_friendship = Friendship.add_friend(current_user.id, params[:friend_id], "pending")
  	flash[:notice] = "Request Sent!"
  	redirect_to users_path
  end

  def accept
  	@friendship1 = Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
  	@friendship2 = Friendship.find_by(friend_id: current_user.id, user_id: params[:id])
  	friendship_params = params.require(:friendship).permit(:state)
  	@friendship1.update(friendship_params)
  	@friendship2.update(friendship_params)
  	redirect_to user_path(current_user.id), notice: "Friend Successfully Accepted!"
  end

  def reject
  	@friendship1 = Friendship.find_by(friend_id: params[:id], user_id: current_user.id)
  	@friendship2 = Friendship.find_by(friend_id: current_user.id, user_id: params[:id])
  	@friendship1.destroy
  	@friendship2.destroy
  	redirect_to user_path(current_user.id), alert: "Removed!"
  end  
end
