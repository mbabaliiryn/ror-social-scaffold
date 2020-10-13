class VotesController < ApplicationController
    def create
        @vote = current_user.votes.new(post_id: params[:post_id])
    
        if @vote.save
          redirect_to posts_path, notice: 'You voted a post.'
        else
          redirect_to posts_path, alert: 'You cannot unvote this post.'
        end
      end
    
      def destroy
        vote = Vote.find_by(id: params[:id], user: current_user, post_id: params[:post_id])
        if vote
          vote.destroy
          redirect_to posts_path, notice: 'You unvoted a post.'
        else
          redirect_to posts_path, alert: 'You cannot unvote post that you did not vote before.'
        end
      end
end