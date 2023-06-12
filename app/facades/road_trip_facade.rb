class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    RoadTrip.new(road_trip_data, forecast_data)
  end

  private

  def service
    _service ||= MapService.new
  end

  def forecast_data
    _forecast_data ||= ForecastFacade.new(@destination).forecast
  end

  def road_trip_data
    _road_trip_data ||= service.get_directions(@origin, @destination)
  end
end