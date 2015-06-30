class FacebookPostsController < ApplicationController
  skip_load_and_authorize_resource

  def index
    @facebook_posts = FacebookPost.get_all_posts(params)
    @page_info = FacebookPost.page_info

    @drafts = FacebookPost.where(draft: true)
  end

  def new
    @facebook_post = FacebookPost.new
    if params[:draft_id].present?
      @draft = FacebookPost.find(params[:draft_id])
      @facebook_post.message = @draft.message if @draft.present?
    end
  end

  def edit
    data = FacebookPost.get_post_data(params[:id])

    @facebook_post = FacebookPost.new
    @facebook_post.facebook_id = params[:id]
    @facebook_post.message = data['message']
    @facebook_post.published = data['is_published']
    @facebook_post.scheduled_publish_time = Time.at(data['scheduled_publish_time']) if data['scheduled_publish_time']

    @photo_attachments = photo_attachments(data)

  end

  def show
    @facebook_post = FacebookPost.get_post_data(params[:id])
    @photo_attachments = photo_attachments(@facebook_post)
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

  def update
    @facebook_post = FacebookPost.new(facebook_post_params)
    @facebook_post.facebook_id = params[:id]

    if @facebook_post.update
        redirect_to facebook_post_path(id: params[:id]), notice: 'This post was successfully updated.'
    else
      render action: 'edit', alert: 'there was an issue with your post'
    end
  end

  def delete
    FacebookPost.delete_post(params[:id])
    redirect_to facebook_posts_path, notice: 'Post was successfully deleted.'
  end

  def delete_draft
    FacebookPost.find(params[:id]).delete
    redirect_to facebook_posts_path, notice: 'Draft was successfully deleted.'
  end

  def facebook_post_params
    params.require(:facebook_post).permit(:status, :message, :published, :scheduled_publish_time, :facebook_id, :draft_id)
  end

  def photo_attachments(facebook_post)
    if facebook_post['type'] == 'photo'
      if facebook_post['attachments']['data'].first['subattachments']
        facebook_post['attachments']['data'].first['subattachments']['data']
      else
        facebook_post['attachments']['data']
      end
    end
  end
end
