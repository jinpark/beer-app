class FriendshipsController < ApplicationController

  before_filter :authenticate_user!

  def create
    # @follower = Follower.new
    # @follower.followee_id = params[:follower][:followee_id]
    # @follower.user_id = current_user.id
    # p @follower
    # @follower.save
    @friendship = current_user.friendships.build(params[:friendship])
    @friendship.save
    redirect_to user_url(@friendship.friend_id)
  end

  def destroy
    @friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, params[:friendship][:friend_id])
    p "LOOK HERE"
    p @friendship
    if @friendship
      p "SHIT IS HAPPENING"
      friend_id = @friendship.friend_id
      @friendship.destroy
      redirect_to user_url(friend_id)
    else
      p "SHIT IS FAILING TO HAPPEN"
      flash[:notice] = "Failed to unfollow"
      redirect_to root_url
    end
  end

end
