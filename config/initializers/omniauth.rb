Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
  #should read from env and yaml file, I will make it work for now.
  provider :facebook, '1440319669516663', 'a5ba5679f8b7ee6d4d02e7d68c282c66'
end