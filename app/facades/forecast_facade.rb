class ForecastFacade
  def fetch_forecast(location)
    coordinates = coord_facade.fetch_coordinates(location)
    forecast_data = service.get_forecast(coordinates.lat, coordinates.lng)
    Forecast.new(forecast_data)
  end

  private

  def service
    _service ||= WeatherService.new
  end

  def coord_facade
    _coord_facade ||= CoordinatesFacade.new
  end
end