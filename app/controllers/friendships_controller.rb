class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])

    if @friendship.save
      redirect_to root_path, notice: 'Added Friend'
    else
      redirect_to users_path, error: 'Unable to add friend'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to root_path, notice: 'Removed Friendship'
  end
end