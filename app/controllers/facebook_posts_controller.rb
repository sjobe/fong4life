class FacebookPostsController < ApplicationController
  skip_load_and_authorize_resource

  def index
    @facebook_posts = FacebookPost.get_all_posts(params)
    @page_info = FacebookPost.page_info
  end

  def new
    @facebook_post = FacebookPost.new
  end

  def show
    @facebook_post = FacebookPost.get_post_data(params[:id])
    if @facebook_post['type'] == 'photo'
      if @facebook_post['attachments']['data'].first['subattachments']
          @photo_attachments = @facebook_post['attachments']['data'].first['subattachments']['data']
      else
        @photo_attachments = @facebook_post['attachments']['data']
      end

    end
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

  def delete
    FacebookPost.delete_post(params[:id])
    redirect_to facebook_posts_path, notice: 'Post was successfully deleted.'
  end

  def facebook_post_params
    params.require(:facebook_post).permit(:status, :message, :published, :scheduled_publish_time)
  end
end
