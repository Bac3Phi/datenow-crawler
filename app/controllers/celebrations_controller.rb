class CelebrationsController < ApplicationController
  before_action :set_celebration, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:index]
  skip_before_action :verify_authenticity_token
  # GET /celebrations
  # GET /celebrations.json
  def index
    @celebrations = @user ? @user.celebrations : Celebration.all
  end

  # GET /celebrations/1
  # GET /celebrations/1.json
  def show
  end

  # GET /celebrations/new
  def new
    @celebration = Celebration.new
  end

  # GET /celebrations/1/edit
  def edit
  end

  # POST /celebrations
  # POST /celebrations.json
  def create
    @celebration = Celebration.new(celebration_params)

    respond_to do |format|
      if @celebration.save
        format.json { render :json => {:success => true, celebration: @celebration} }
        format.html { redirect_to @celebration, notice: "Celebration was successfully created." }
      else
        format.json { render :json => {:success => false, message: @celebration.errors} }
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /celebrations/1
  # PATCH/PUT /celebrations/1.json
  def update
    respond_to do |format|
      if @celebration.update(celebration_params)
        format.json { render :json => {:success => true, celebration: @celebration} }
        format.html { redirect_to @celebration, notice: "Celebration was successfully updated." }
      else
        format.json { render :json => {:success => false, message: @celebration.errors} }
        format.html { render :edit }
      end
    end
  end

  # DELETE /celebrations/1
  # DELETE /celebrations/1.json
  def destroy
    @celebration.destroy
    respond_to do |format|
      format.json { render :json => {:success => true, :message => "Celebration was destroyed"} }
      format.html { redirect_to celebrations_url, notice: "Celebration was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_celebration
    @celebration = Celebration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def celebration_params
    params.require(:celebration).permit(:user_id, :title, :date_celebration, :note)
  end

  def find_user
    if params[:user_id].present?
      @user = User.find(params[:user_id])
    end
  end
end
