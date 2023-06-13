class BookSearch
  attr_reader :id, :destination, :forecast, :total_books_found, :books

  def initialize(location, quantity, book_data, forecast_data)
    @id = nil
    @destination = location
    @forecast = {
      summary: forecast_data[:current][:condition][:text],
      temperature: "#{forecast_data[:current][:temp_f]} F"
    }
    @total_books_found = book_data[:numFound]
    @books = extract_books(book_data[:docs], quantity)
  end

  private

  def extract_books(docs, quantity)
    docs.take(quantity).map do |doc|
      {
        isbn: doc[:isbn],
        title: doc[:title_suggest],
        publisher: doc[:publisher]
      }
    end
  end
end