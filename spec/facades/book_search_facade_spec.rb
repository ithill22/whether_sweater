require 'rails_helper'

RSpec.describe 'Book Search Facade' do
  describe 'class methods' do
    describe '#books' do
      it 'returns a list of books', :vcr do
        books = BookSearchFacade.new('denver,co', '5').books

        expect(books).to be_a(BookSearch)
        expect(books.destination).to be_a(String)
        expect(books.forecast).to be_a(Hash)
        expect(books.forecast[:summary]).to be_a(String)
        expect(books.forecast[:temperature]).to be_a(String)
        expect(books.total_books_found).to be_a(Integer)
        expect(books.books).to be_a(Array)
        expect(books.books.first).to be_a(Hash)
        expect(books.books.first[:isbn]).to be_a(Array)
        expect(books.books.first[:title]).to be_a(String)
        expect(books.books.first[:publisher]).to be_a(Array)
      end
    end
  end
end