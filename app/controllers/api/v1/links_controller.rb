class Api::V1::LinksController < ApplicationController

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(link_params)
      render json: @link
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      render partial: 'links/link-show', locals: {link: link}
    else
      render json: link.errors.full_messages, status: 500
    end
  end

  private

  def link_params
      params.permit(:read, :user_id, :title, :url)
  end
end
