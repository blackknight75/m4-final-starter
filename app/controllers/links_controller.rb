class LinksController < ApplicationController
before_action :authorize

  def index
    @link = Link.new
    @links = Link.all
  end
end
