class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  helper_method :resource_name, :resource, :devise_mapping

  def default_url_options
    if Rails.env.production?
      {:host => "localhost:3000"}
    elsif Rails.env.test?
      {:host => "localhost:3000"}
    else
      {}
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
