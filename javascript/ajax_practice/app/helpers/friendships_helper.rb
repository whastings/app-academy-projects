module FriendshipsHelper

  def friend_button_class(friendee_id, friender_id)
    if Friendship.can_friend?(friendee_id, friender_id)
      "can-friend"
    elsif Friendship.can_unfriend?(friendee_id, friender_id)
      "can-unfriend"
    else
      ""
    end
  end

end
