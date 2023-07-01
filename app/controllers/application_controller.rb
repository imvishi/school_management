class ApplicationController < ActionController::Base  
  before_action :authenticate_user

  def authenticate_user
    user_id = session[:user_id]

    @current_user = User.find_by(id:user_id)

    render json: { message: 'User not found' }, status: 404 if @current_user.blank?
  end

  def validate_admin
    return if @current_user.admin?

    flash[:notice] = 'Unauthorize user'
    redirect_to welcome_page_admin_users_path
  end
end
