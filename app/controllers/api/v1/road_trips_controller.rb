class Api::V1::RoadTripsController < ApplicationController
  rescue_from RoadTripFacade::InvalidApi, with: :render_api_invalid

  def create
    road_trip = RoadTripFacade.new(params[:origin], params[:destination]).road_trip
    render json: RoadTripSerializer.new(road_trip)
  end

  private

  def render_api_invalid(exception)
    render json: { errors: { detail: "Invalid Api Key" } }, status: :unprocessable_entity
  end
end