Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"]
  #should read from env and yaml file, I will make it work for now.
  provider :facebook, '1445057605716906', 'a3e7f849c8e3371eee0f2a6ee62aef11'
end