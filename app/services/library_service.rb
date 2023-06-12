class LibraryService
  def get_books(location)
    get_url("/search.json?q=#{location}&page=1")
  end

  private

  def conn
    Faraday.new(url: 'https://openlibrary.org')
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end