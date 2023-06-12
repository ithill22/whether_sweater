class BookSearchFacade
  def initialize(location, quantity)
    @location = location
    @quantity = quantity.to_i
  end

  def books
    BookSearch.new(@location, @quantity, book_data, forecast_data)
  end

  private

  def forecast_data
    @forecast_data ||= WeatherService.new.get_forecast(coordinates.lat, coordinates.lng)
  end

  def book_data
    @book_data ||= LibraryService.new.get_books(@location, @quantity)
  end

  def coordinates
    @coordinates ||= Coordinates.new(MapService.new.get_coordinates(@location))
  end
end