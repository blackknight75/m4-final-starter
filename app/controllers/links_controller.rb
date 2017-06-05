class LinksController < ApplicationController
before_action :authorize

  def index
    @link = Link.new
    @links = Link.where(["user_id = ?", "#{current_user.id}"])
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:success] = "You successfully updated your link."
      redirect_to links_path
    else
      if @link.title == ""
        flash.now[:alert] = "Sorry, TITLE cannot be blank."
      else
        flash.now[:alert] = "Sorry, that is not a valid URL."
      end
      render :edit
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
