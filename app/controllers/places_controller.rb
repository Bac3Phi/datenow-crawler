class PlacesController < ApplicationController
  def index
    @refresh_params = refresh_params
    @places, @errors = Meete::Place.random(query, clear_cache)
    render json: @places
  end

  def show
    @place = Meete::Place.find(params[:id])
    render json: @place
  end

  private

  def query
    request.query_parameters
  end

  def clear_cache
    params[:clear_cache].present?
  end

  def refresh_params
    refresh = {clear_cache: true}
    refresh.merge!({query: query}) if query.present?
    refresh
  end
end
