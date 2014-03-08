class FriendshipsController < ApplicationController

  def create
    @friendship = Friendship.new(:friender_id => current_user.id,
                                :friendee_id  => params[:user_id])
    @friendship.save!
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :ok }
    end
  end

  def destroy
    @friendship = Friendship.find_by(:friender_id => current_user.id,
                                    :friendee_id => params[:id])

    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

end
