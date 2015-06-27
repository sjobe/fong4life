class FacebookPostsController < ApplicationController
  def index
    @facebook_posts = FacebookPost.get_all_posts(params)
    @page_info = FacebookPost.page_info
  end

  def new

  end
end
