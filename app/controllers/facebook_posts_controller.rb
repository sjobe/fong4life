class FacebookPostsController < ApplicationController
  def index
    @facebook_posts = FacebookPost.get_all_posts(params)
    @page_info = FacebookPost.page_info
  end

  def new

  end

  def create
    @facebook_post = FacebookPost.new(facebook_post_params)
    image_added = false
    if params[:image_attachments].present?
      params[:image_attachments].each do |index, image_attachment|
        res = @facebook_post.add_photo(image_attachment)
      end
      image_added = true
    else
      res = @facebook_post.post
    end
    if image_added || res['id']
      if request.xhr?
        flash[:notice] = "Post successfully created"
        render text: image_added || res['id']
      else
        redirect_to facebook_posts_path, notice: 'Post was successfully created.'
      end
    else
      render action: 'new', alert: 'there was an issue with your post'
    end
  end

  def facebook_post_params
    params.require(:facebook_post).permit(:status, :message, :published, :scheduled_publish_time)
  end
end
