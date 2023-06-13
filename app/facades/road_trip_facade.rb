class RoadTripFacade
  class InvalidApi < StandardError; end

  def initialize(origin, destination, api_key)
    @origin = origin
    @destination = destination
    @api_key = api_key
  end

  def road_trip
    validate_api_key!

    RoadTrip.new(@origin, @destination, road_trip_data, forecast_data)
  end

  private

  def validate_api_key!
    user = User.find_by(api_key: @api_key)
    raise InvalidApi if user.nil?
  end

  def service
    _service ||= MapService.new
  end

  def forecast_data
    _forecast_data ||= Forecast.new(WeatherService.new.get_forecast(coordinates.lat, coordinates.lng))
  end

  def road_trip_data
    _road_trip_data ||= service.get_directions(@origin, @destination)
  end

  def coordinates
    _coordinates ||= Coordinates.new(service.get_coordinates(@destination))
  end
end