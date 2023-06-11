class MapService
  def get_coordinates(location)
    get_url("address?location=#{location}")
  end

  private

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com/geocoding/v1/') do |f|
      f.params['key'] = ENV['MAP_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end