class FacebookPost
  include Mongoid::Document
  include Mongoid::Timestamps

  POSTS_PER_PAGE = 10

  field :facebook_id, type: String
  field :status, type: String
  field :message, type: String
  field :published, type: Boolean
  field :scheduled_publish_time, type: DateTime
  field :image_attachments

  def self.graph
    Koala.config.api_version = "v2.3"
    @graph ||= Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_LONG_LIVED_TOKEN'])
  end

   def self.get_all_posts(params = {})
     params[:page] ?
         graph.get_page(params[:page]) :
         graph.get_connection(ENV['FACEBOOK_PAGE_SLUG'], 'promotable_posts', limit: POSTS_PER_PAGE)
   end

  def post
    res =  FacebookPost::post_to_page(self.options)
    self.facebook_id = res['id']
    res
  end

  def update
    FacebookPost.graph.put_connections(self.facebook_id, nil, self.options)
  end

  def self.delete_post(id)
    graph.delete_object(id)
  end

  def options
    options = {
        message: self.message,
        published: self.published
    }

    if(self.scheduled_publish_time.present?)
      options[:scheduled_publish_time] = self.scheduled_publish_time.to_i
      options[:published] = false
    end
    options
  end

  def add_photo(image_attachment)
    # upload to facebook
    # persist to db
    FacebookPost.graph.put_picture(image_attachment, self.options, ENV['FACEBOOK_PAGE_SLUG'])
  end

  def self.post_to_page(options)
    # scheduled_publish_time: unix timestamp
    # published: boolean
    # to publish Page posts, using the scheduled_publish_time field and the published field with a value of false.
    #graph.put_connections(ENV['FACEBOOK_PAGE_SLUG'], 'feed', {message: content, published: true})
    graph.put_connections(ENV['FACEBOOK_PAGE_SLUG'], 'feed', options)
  end

  def self.get_post_data(id)
    opts = {
        fields: 'attachments,message,type,scheduled_publish_time,is_published,link,insights,picture'
    }
    graph.get_object(id, opts)
  end

  def self.page_info
    graph.get_object(ENV['FACEBOOK_PAGE_SLUG'])
  end
end
