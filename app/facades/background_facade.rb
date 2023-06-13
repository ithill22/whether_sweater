class BackgroundFacade
  def initialize(location)
    @location = location
  end

  def background
    Image.new(@location, image_data)
  end

  private

  def image_data
    @image_data ||= ImageService.new.get_image(@location)
  end
end