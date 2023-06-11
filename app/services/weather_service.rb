class WeatherService
  def get_forecast(lat, lng)
    get_url("/v1/forecast.json?q=#{lat},#{lng}&days=5")
  end

  private

  def conn
    Faraday.new(url: 'https://api.weatherapi.com') do |f|
      f.params['key'] = ENV['WEATHER_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end