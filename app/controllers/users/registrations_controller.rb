class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      render :json => {:success => true,
                       :user => user.as_json(
               :auth_token => user.authentication_token,
               :email => user.email,
             )},
             :status => 201
      return
    else
      warden.custom_failure!
      render :json => {:success => false,
                       :message => user.errors.full_messages}, :status => 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end
end
