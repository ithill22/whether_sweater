class RoadTrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(road_trip_data, forecast_data)
    @id = nil
    @start_city = start_city
    @end_city = end_city
    @travel_time = travel_time
    @weather_at_eta = weather_at_eta
  end

  private

  def start_city
    city = road_trip_data[:route][:locations][0][:adminArea5]
    state = road_trip_data[:route][:locations][0][:adminArea3]
    "#{city}, #{state}"
  end

  def end_city
    city = road_trip_data[:route][:locations][1][:adminArea5]
    state = road_trip_data[:route][:locations][1][:adminArea3]
    "#{city}, #{state}"
  end

  def travel_time
    if road_trip_data[:route][:routeError][:errorCode] == 2
      "Impossible route"
    else
      time = road_trip_data[:route][:formattedTime]
      hours, minutes = time.split(':').map(&:to_i)
      formatted_time = "#{hours} hours, #{minutes} minutes"
      formatted_time
    end
  end

  def weather_at_eta
    if road_trip_data[:route][:routeError][:errorCode] == 2
      {}
    else
      hours, minutes = travel_time.split(':').map(&:to_i)
      time = Time.now + (hours * 60 * 60) + (minutes * 60)
      {
        datetime: time.strftime('%Y-%m-%d %H:%M:%S %z'),
        temperature: forecast_data.hourly[hours][:temperature],
        conditions: forecast_data.hourly[hours][:conditions]
      }
    end
  end


end