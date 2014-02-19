class UsersController < ApplicationController
  def index
    @users = User.all
    render :json => @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :json => @user
    else
      render :json => @user.errors.full_messages,
        :status => :unprocessable_entity
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    render :json => @user
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user && @user.update_attributes(user_params)
      render :json => @user
    else
      render :json => @user.errors.full_messages,
        :status => :unprocessable_entity
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user && @user.destroy
      render :json => @user
    else
      head status: 404
    end
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites

    render :json => @favorites
  end

  def add_favorite
    @user = User.find(params[:id])
    @user.favorite!(Integer(params[:contact_id]))

    redirect_to favorites_user_url(@user)
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email)
  end
end
