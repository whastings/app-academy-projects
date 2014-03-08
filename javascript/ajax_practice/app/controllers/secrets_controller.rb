class SecretsController < ApplicationController
  def new
    @recipient = User.find(params[:user_id])
    @secret = Secret.new
  end

  def create
    @secret = Secret.new(secret_params)
    @secret.author_id = current_user.id

    respond_to do |format|
      if @secret.save
        format.html { redirect_to user_url(@secret.user_id) }
        format.json { render :json => @secret }
      else
        errors = @secret.errors.full_messages
        format.html do
          flash.now[:errors] = errors
          render :new
        end
        format.json { render :json => errors, :status => 422 }
      end
    end
  end

  private

  def secret_params
    secret_data = params
                    .require(:secrets)
                    .permit(:title, :recipient_id, :tag_ids => [])

    secret_data[:tag_ids].uniq!

    secret_data
  end

end
