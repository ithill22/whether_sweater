require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'book search request' do
    describe 'happy path' do
      it 'returns a list of books for a given location', :vcr do
        get '/api/v1/book-search?location=denver,co&quantity=5', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to eq(nil)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq('books')

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:destination)
        expect(json[:data][:attributes][:destination]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:forecast)
        expect(json[:data][:attributes][:forecast]).to be_a(Hash)

        expect(json[:data][:attributes][:forecast]).to have_key(:summary)
        expect(json[:data][:attributes][:forecast][:summary]).to be_a(String)

        expect(json[:data][:attributes][:forecast]).to have_key(:temperature)
        expect(json[:data][:attributes][:forecast][:temperature]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:total_books_found)
        expect(json[:data][:attributes][:total_books_found]).to be_a(Integer)

        expect(json[:data][:attributes]).to have_key(:books)
        expect(json[:data][:attributes][:books]).to be_a(Array)

        expect(json[:data][:attributes][:books].first).to have_key(:isbn)
        expect(json[:data][:attributes][:books].first[:isbn]).to be_a(Array)

        expect(json[:data][:attributes][:books].first).to have_key(:title)
        expect(json[:data][:attributes][:books].first[:title]).to be_a(String)

        expect(json[:data][:attributes][:books].first).to have_key(:publisher)
        expect(json[:data][:attributes][:books].first[:publisher]).to be_a(Array)

        expect(json[:data][:attributes][:books].count).to eq(5)
      end
    end
  end
end