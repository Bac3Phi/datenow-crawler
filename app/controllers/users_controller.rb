class UsersController < ApplicationController
  before_action :set_user, only: [:index, :show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    render json: @user.as_json
    # @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :json => {status: :ok, location: @user}
    else
      Rails.logger.info(@user.errors.messages.inspect)
      render :json => {error: :@user.errors, status: :unprocessable_entity}
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_token
    user = User.find_by_authentication_token(params[:user][:authentication_token])
    unless user.nil?
        render :json => {:success => true, :message => "Authenticated successful"}
        return
    end
    render :json => {:success => false, :message => "Wrong authentication token"}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :name, :avatar, :lover_name, :lover_avatar, :start_date)
  end
end
