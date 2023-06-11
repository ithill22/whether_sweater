class Coordinates
  attr_reader :lat, :lng

  def initialize(coord_data)
    @lat = coord_data[:results][0][:locations][0][:latLng][:lat]
    @lng = coord_data[:results][0][:locations][0][:latLng][:lng]
  end
end