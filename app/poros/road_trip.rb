class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(origin, destination, road_trip_data, forecast_data)
    @id = nil
    @start_city = origin
    @end_city = destination
    @travel_time = extract_travel_time(road_trip_data)
    @weather_at_eta = @travel_time == 'impossible' ? {} : extract_weather(forecast_data, road_trip_data)
  end

  private

  def extract_travel_time(road_trip_data)
    road_trip_data[:route][:formattedTime] || 'impossible'
  end

  def extract_weather(forecast_data, road_trip_data)
    eta_time = calculate_eta_time(road_trip_data)

    forecast = forecast_data.hourly.find do |hourly_forecast|
      hourly_forecast[:time] == eta_time.strftime('%Y-%m-%d %H:00')
    end

    {
      datetime: eta_time.strftime('%Y-%m-%d %H:%M:%S %z'),
      temperature: forecast[:temperature],
      condition: forecast[:conditions]
    }
  end

  def calculate_eta_time(road_trip_data)
    current_time = Time.now
    travel_duration = road_trip_data[:route][:realTime]
    arrival_time = current_time + travel_duration
    
    Time.at(arrival_time)
  end
end