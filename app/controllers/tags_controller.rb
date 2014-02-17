class TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag && @tag.destroy
      flash.notice = 'Tag Deleted!'
    end
    redirect_to tags_path
  end

end
