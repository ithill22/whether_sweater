require 'rails_helper'

RSpec.describe 'Background API' do
  describe 'background request' do
    describe 'happy path' do
      it 'returns a background image for a given location', :vcr do
        get '/api/v1/backgrounds?location=denver,co', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to eq(nil)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq('image')

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:location)
        expect(json[:data][:attributes][:location]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:image_url)
        expect(json[:data][:attributes][:image_url]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:credit)
        expect(json[:data][:attributes][:credit]).to be_a(Hash)

        expect(json[:data][:attributes][:credit]).to have_key(:source)
        expect(json[:data][:attributes][:credit][:source]).to be_a(String)

        expect(json[:data][:attributes][:credit]).to have_key(:author)
        expect(json[:data][:attributes][:credit][:author]).to be_a(String)

        expect(json[:data][:attributes][:credit]).to have_key(:logo)
        expect(json[:data][:attributes][:credit][:logo]).to be_a(String)

      end
    end
  end
end