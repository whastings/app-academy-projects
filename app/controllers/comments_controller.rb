class CommentsController < ApplicationController

  def index
    @contact = Contact.find(params[:contact_id])
    render :json => [@contact, @contact.comments]
  end

  def create
  end
end
