class ApplicationController < ActionController::Base
  private

  def current_user
    @current_user ||= User.find_by_id session[:user_id] 
  end
  helper_method :current_user

  # Helper method makes this method visible to all the 
  # controller's views.

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
     flash[:danger] = "Please Sign In"
     redirect_to new_sessions_path
    end 
  end


end
