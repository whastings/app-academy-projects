class GroupsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @groups = @user.groups

    render :json => @groups
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      redirect_to @group
    else
      render :json => @group.errors.full_messages, status: 422
    end
  end

  def show
    @group = Group.find(params[:id])

    render :json => {"result" => @group, "contacts" => @group.contacts}
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    render :json => @group
  end

  private

  def group_params
    params.require(:group).permit(:group_name, :user_id)
  end
end
