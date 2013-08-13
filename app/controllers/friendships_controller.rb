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
    if request.xhr?
      # Render a partial as response when using ajax requests.
      render partial: 'users/unfollow_button', locals: {user: User.find(@friendship.friend_id), current_user: current_user, friend: [@friendship]}
    else
      redirect_to user_url(@friendship.friend_id)
    end
  end

  def destroy
    @friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, params[:friendship][:friend_id])
    p "LOOK HERE"
    p @friendship
    if @friendship
      p "LOOK HERE FOR XHR"
      p request
      friend_id = @friendship.friend_id
      @friendship.destroy
      if request.xhr?
        # Render a partial as response when using ajax requests.
        render partial: 'users/follow_button', locals: {user: User.find(friend_id), current_user: current_user}
      else
        p "UH OH"
        redirect_to user_url(friend_id)
      end

    else
      flash[:notice] = "Failed to unfollow"
      redirect_to root_url
    end
  end

end
