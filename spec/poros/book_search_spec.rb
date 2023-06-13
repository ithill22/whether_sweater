require 'rails_helper'

RSpec.describe BookSearch do
  describe '#initialize' do
    let(:location) { 'denver,co' }
    let(:quantity) { 5 }
    let(:book_data) do
      {
        numFound: 10,
        docs: [
          { isbn: '0762507845', title_suggest: 'Book 1', publisher: 'Publisher 1' },
          { isbn: '0883183668', title_suggest: 'Book 2', publisher: 'Publisher 2' },
          { isbn: '1234567890', title_suggest: 'Book 3', publisher: 'Publisher 3' },
          { isbn: '0987654321', title_suggest: 'Book 4', publisher: 'Publisher 4' },
          { isbn: '5432109876', title_suggest: 'Book 5', publisher: 'Publisher 5' },
          { isbn: '1111111111', title_suggest: 'Book 6', publisher: 'Publisher 6' },
          { isbn: '2222222222', title_suggest: 'Book 7', publisher: 'Publisher 7' },
          { isbn: '3333333333', title_suggest: 'Book 8', publisher: 'Publisher 8' },
          { isbn: '4444444444', title_suggest: 'Book 9', publisher: 'Publisher 9' },
          { isbn: '5555555555', title_suggest: 'Book 10', publisher: 'Publisher 10' }
        ]
      }
    end

    let(:forecast_data) do
      {
        current: {
          condition: { text: 'Cloudy' },
          temp_f: 72
        }
      }
    end

    subject { BookSearch.new(location, quantity, book_data, forecast_data) }

    it 'sets the instance variables correctly' do
      expect(subject.destination).to eq(location)
      expect(subject.forecast[:summary]).to eq('Cloudy')
      expect(subject.forecast[:temperature]).to eq('72 F')
      expect(subject.total_books_found).to eq(10)

      expect(subject.books).to be_a(Array)
      expect(subject.books.length).to eq(quantity)

      expect(subject.books.first[:isbn]).to eq('0762507845')
      expect(subject.books.first[:title]).to eq('Book 1')
      expect(subject.books.first[:publisher]).to eq('Publisher 1')
    end
  end
end
