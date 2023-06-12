class BookSearchFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity.to_i
  end

  def books
    BookSearch.new(@location, @quantity, book_data, forecast_data)
  end

  private

  def service
    _service ||= LibraryService.new
  end

  def forecast_service
    _forecast_service ||= WeatherService.new
  end

  def map_service
    _map_service ||= MapService.new
  end
  
  def coordinates_data
    _coordinates_data ||= map_service.get_coordinates(@location)
  end

  def coordinates
    _coordinates ||= Coordinates.new(coordinates_data)
  end

  def forecast_data
    _forecast_data ||= forecast_service.get_forecast(coordinates.lat, coordinates.lng)
  end

  def book_data
    _book_data ||= service.get_books(@location, @quantity)
  end
end