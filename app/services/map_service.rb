class MapService
  def get_coordinates(location)
    get_url("geocoding/v1/address?location=#{location}")
  end

  def get_directions(origin, destination)
    get_url("directions/v2/route?from=#{origin}&to=#{destination}")
  end

  private

  def conn
    Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params['key'] = ENV['MAP_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end