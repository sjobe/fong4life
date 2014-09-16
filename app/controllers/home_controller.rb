class HomeController < ApplicationController
  skip_before_action :check_login
  def index
    if current_user.present?
      redirect_to blood_drives_path
    end
  end
end
