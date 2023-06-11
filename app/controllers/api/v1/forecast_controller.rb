class Api::V1::ForecastController < ApplicationController
  rescue_from ForecastFacade::LocationError, with: :invalid_request

  def index
    forecast = ForecastFacade.new(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  private

  def invalid_request(exception)
    render json: {errors: exception.message}, status: :bad_request
  end
end