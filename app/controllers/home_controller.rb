class HomeController < ApplicationController
  skip_before_action :check_login
  skip_load_and_authorize_resource

  def index
    if current_user.present?
      if can? :read, BloodDrive
        redirect_to blood_drives_path
      elsif can? :read, Emergency
        redirect_to emergencies_path
      end
    end
  end
end
