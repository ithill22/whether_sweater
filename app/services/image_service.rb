class ImageService
  def get_image(location)
    get_url("/search/photos?query=#{location}&per_page=1")
  end

  private

  def conn
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params['client_id'] = ENV['IMAGE_API_KEY']
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end