class ForecastFacade
  def initialize(location)
    @location = location
  end

  def forecast
    Forecast.new(forecast_data)
  end

  private

  def service
    _service ||= WeatherService.new
  end

  def coord_facade
    _coord_facade ||= CoordinatesFacade.new
  end

  def coordinates
    _coordinates ||= coord_facade.fetch_coordinates(@location)
  end

  def forecast_data
    _forecast_data ||= service.get_forecast(coordinates.lat, coordinates.lng)
  end
end