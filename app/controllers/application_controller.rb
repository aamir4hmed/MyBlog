class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # skip_before_action :verify_authenticity_token
  helper_method :current_user
  
  rescue_from OAuth2::Error do |exception|
    puts exception.response.status
    if exception.response.status == 401
      session[:user_id] = nil
      session[:access_token] = nil
      redirect_to new_session_path, alert: "Try signing in again."
    end
  end


  private
  def current_user
    if doorkeeper_token
      @current_user ||= User.find_by(id: doorkeeper_token.resource_owner_id)
    else
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
