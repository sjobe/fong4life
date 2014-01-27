Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
  #should read from env and yaml file, I will make it work for now.
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'] 
end
