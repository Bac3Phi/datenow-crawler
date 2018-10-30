class DealsController < ApplicationController

  def index
    @refresh_params = refresh_params
    @deals, @errors = Meete::Deal.random(query, clear_cache)
    render json: @deals
  end

  def show
    @deal = Meete::Deal.find(params[:id])
    render json: @deal
  end

  private
  def query
    request.query_parameters
  end

  def clear_cache
    params[:clear_cache].present?
  end

  def refresh_params
    refresh = { clear_cache: true }
    refresh.merge!({ query: query }) if query.present?
    refresh
  end
end
