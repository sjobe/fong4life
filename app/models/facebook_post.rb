class FacebookPost
  include Mongoid::Document

  POSTS_PER_PAGE = 10

  field :status, type: String
  field :message, type: String
  field :unpublished, type: Boolean

  def self.graph
    @graph ||= Koala::Facebook::API.new(ENV['FACEBOOK_PAGE_LONG_LIVED_TOKEN'])
  end

   def self.get_all_posts(params = {})
     params[:page] ?
         graph.get_page(params[:page]) :
         graph.get_connection(ENV['FACEBOOK_PAGE_SLUG'], 'promotable_posts', limit: POSTS_PER_PAGE)
   end

  def self.post_to_wall(content)
    # scheduled_publish_time: unix timestamp
    # published: boolean
    # to publish Page posts, using the scheduled_publish_time field and the published field with a value of false.
    graph.put_connections(ENV['FACEBOOK_PAGE_SLUG'], 'feed', {message: content, published: true})
  end

  def self.page_info
    graph.get_object(ENV['FACEBOOK_PAGE_SLUG'])
  end
end
