class CoordinatesFacade
  def fetch_coordinates(location)
    coord_data = service.get_coordinates(location)
    Coordinates.new(coord_data)
  end

  private

  def service
    _service ||= MapService.new
  end
end