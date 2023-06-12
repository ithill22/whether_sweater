class Forecast
  attr_reader :id, :current, :daily, :hourly

  def initialize(forecast_data)
    @id = nil
    @data = forecast_data
    @current = current
    @daily = daily
    @hourly = hourly
  end

  def current
    {
      last_updated: @data[:current][:last_updated],
      temperature: @data[:current][:temp_f],
      feels_like: @data[:current][:feelslike_f],
      humidity: @data[:current][:humidity],
      uvi: @data[:current][:uv],
      visibility: @data[:current][:vis_miles].to_i,
      conditions: @data[:current][:condition][:text],
      icon: @data[:current][:condition][:icon]
    }
  end

  def daily
    @data[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        conditions: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end

  def hourly
    @data[:forecast][:forecastday][0][:hour].map do |hour|
      {
        time: hour[:time],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end
  end
end