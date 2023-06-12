class Api::V1::ForecastController < ApplicationController
  rescue_from ForecastFacade::CoordinatesError, with: :invalid_request

  def index
    forecast = ForecastFacade.new(params[:location]).forecast
    render json: ForecastSerializer.new(forecast)
  end

  private

  def invalid_request(exception)
    render json: {errors: { detail: exception.message } }, status: :bad_request
  end
end