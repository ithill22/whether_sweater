class ForecastFacade
  class CoordinatesError < StandardError; end

  def initialize(location)
    @location = location
  end

  def forecast
    Forecast.new(forecast_data)
  end

  def coordinates
    raise CoordinatesError, coordinates_data[:info][:messages][0] if coordinates_data[:info][:statuscode] == 400

    _coordinates ||= Coordinates.new(coordinates_data)
  end

  private

  def service
    _service ||= WeatherService.new
  end

  def map_service
    _map_service ||= MapService.new
  end

  def coordinates_data
    _coordinates_data ||= map_service.get_coordinates(@location)
  end

  def forecast_data
    _forecast_data ||= service.get_forecast(coordinates.lat, coordinates.lng)
  end
end