class Users::SessionsController < Devise::SessionsController
  prepend_before_action :require_no_authentication, only: [:create]
  before_action :ensure_params_exist, only: [:create]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = current_user
    unless user.nil?
      if user.valid_password? params[:password]
        render :json => {:success => true, :user => user}
        return
      end
    end
    render :json => {:success => false, :message => "Login failed for user"}
  end

  def destroy
    sign_out(resource_name)
    render :json => {:success => true, :message => "Logout successful"}
  end

  protected

  def ensure_params_exist
    return unless params[:user].blank?
    render :json => {:success => false, :message => "missing user parameter"}, :status => 422
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json => {:success => false, :message => "Error with your login or password"}, :status => 401
  end
end
