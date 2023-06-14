class Image
  attr_reader :id, :image_url, :credit, :location

  def initialize(location, image_data)
    @id = nil
    @location = location
    @image_url = image_data[:results][0][:urls][:raw]
    @credit = {
      source: image_data[:results][0][:links][:html],
      author: image_data[:results][0][:user][:name],
      logo: image_data[:results][0][:user][:profile_image][:small]
    }
  end
end