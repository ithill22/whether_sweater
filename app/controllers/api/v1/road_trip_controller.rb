class Api::V1::RoadTripController < ApplicationController
  rescue_from RoadTripFacade::InvalidApi, with: :render_api_invalid

  def create
    road_trip = RoadTripFacade.new(params[:origin], params[:destination], params[:api_key]).road_trip
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def render_api_invalid(exception)
    render json: { errors: { detail: "Invalid API Key" } }, status: :unauthorized
  end
end