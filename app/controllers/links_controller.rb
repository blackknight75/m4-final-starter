class LinksController < ApplicationController
before_action :authorize

  def index
    @link = Link.new
    @links = Link.where(["user_id = ?", "#{current_user.id}"])
  end

  def create
    link = current_user.links.new(link_params)
    if link.save

    else

    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
