require 'rails_helper'

RSpec.describe 'Forecast API' do
  describe 'forecast request' do
    describe 'happy path' do
      it 'returns a forecast for a given location', :vcr do
        get '/api/v1/forecast?location=denver,co', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to eq(nil)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to eq('forecast')

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:current)
        expect(json[:data][:attributes][:current]).to be_a(Hash)

        expect(json[:data][:attributes][:current]).to have_key(:last_updated)
        expect(json[:data][:attributes][:current][:last_updated]).to be_a(String)

        expect(json[:data][:attributes][:current]).to have_key(:temperature)
        expect(json[:data][:attributes][:current][:temperature]).to be_a(Float)

        expect(json[:data][:attributes][:current]).to have_key(:feels_like)
        expect(json[:data][:attributes][:current][:feels_like]).to be_a(Float)

        expect(json[:data][:attributes][:current]).to have_key(:humidity)
        expect(json[:data][:attributes][:current][:humidity]).to be_a(Integer)

        expect(json[:data][:attributes][:current]).to have_key(:uvi)
        expect(json[:data][:attributes][:current][:uvi]).to be_a(Float)

        expect(json[:data][:attributes][:current]).to have_key(:visibility)
        expect(json[:data][:attributes][:current][:visibility]).to be_a(Integer)

        expect(json[:data][:attributes][:current]).to have_key(:conditions)
        expect(json[:data][:attributes][:current][:conditions]).to be_a(String)

        expect(json[:data][:attributes][:current]).to have_key(:icon)
        expect(json[:data][:attributes][:current][:icon]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:daily)
        expect(json[:data][:attributes][:daily]).to be_a(Array)

        expect(json[:data][:attributes][:daily].first).to have_key(:date)
        expect(json[:data][:attributes][:daily].first[:date]).to be_a(String)

        expect(json[:data][:attributes][:daily].first).to have_key(:sunrise)
        expect(json[:data][:attributes][:daily].first[:sunrise]).to be_a(String)

        expect(json[:data][:attributes][:daily].first).to have_key(:sunset)
        expect(json[:data][:attributes][:daily].first[:sunset]).to be_a(String)

        expect(json[:data][:attributes][:daily].first).to have_key(:max_temp)
        expect(json[:data][:attributes][:daily].first[:max_temp]).to be_a(Float)

        expect(json[:data][:attributes][:daily].first).to have_key(:min_temp)
        expect(json[:data][:attributes][:daily].first[:min_temp]).to be_a(Float)

        expect(json[:data][:attributes][:daily].first).to have_key(:conditions)
        expect(json[:data][:attributes][:daily].first[:conditions]).to be_a(String)

        expect(json[:data][:attributes][:daily].first).to have_key(:icon)
        expect(json[:data][:attributes][:daily].first[:icon]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:hourly)
        expect(json[:data][:attributes][:hourly]).to be_a(Array)

        expect(json[:data][:attributes][:hourly].first).to have_key(:time)
        expect(json[:data][:attributes][:hourly].first[:time]).to be_a(String)

        expect(json[:data][:attributes][:hourly].first).to have_key(:temperature)
        expect(json[:data][:attributes][:hourly].first[:temperature]).to be_a(Float)

        expect(json[:data][:attributes][:hourly].first).to have_key(:conditions)
        expect(json[:data][:attributes][:hourly].first[:conditions]).to be_a(String)
        
        expect(json[:data][:attributes][:hourly].first).to have_key(:icon)
        expect(json[:data][:attributes][:hourly].first[:icon]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'returns an error if location is not found', :vcr do
        get '/api/v1/forecast?location=', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

        expect(response).to_not be_successful
        expect(response.status).to eq(400)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq('Illegal argument from request: Insufficient info for location')
      end
    end
  end
end