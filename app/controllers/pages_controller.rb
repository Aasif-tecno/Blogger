class PagesController < ApplicationController
  def index
    @posts = Post.recently_published.published
  end
end
