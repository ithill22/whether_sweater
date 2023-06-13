require 'rails_helper'

RSpec.describe 'Road Trip API' do
  describe 'Road Trip' do
    describe 'happy path' do
      it 'returns road trip information', :vcr do
        user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                  params: JSON.generate({
                                    origin: "Denver,CO",
                                    destination: "Orlando,FL",
                                    api_key: user.api_key
                                  })

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)
        
        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to eq(nil)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to be_a(String)

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:start_city)
        expect(json[:data][:attributes][:start_city]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:end_city)
        expect(json[:data][:attributes][:end_city]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:travel_time)
        expect(json[:data][:attributes][:travel_time]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:weather_at_eta)
        expect(json[:data][:attributes][:weather_at_eta]).to be_a(Hash)

        expect(json[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
        expect(json[:data][:attributes][:weather_at_eta][:datetime]).to be_a(String)

        expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(json[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)

        expect(json[:data][:attributes][:weather_at_eta]).to have_key(:condition)
        expect(json[:data][:attributes][:weather_at_eta][:condition]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'returns an error if api key is incorrect', :vcr do
        user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                  params: JSON.generate({
                                    origin: "Denver,CO",
                                    destination: "Orlando,FL",
                                    api_key: "123456789"
                                  })

        expect(response).to have_http_status(:unauthorized)
        expect(response.status).to eq(401)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Invalid API Key")
      end

      it "if a route does not exist, it returns 'impossible' and no weather", :vcr do
        user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/road_trip', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                  params: JSON.generate({
                                    origin: "Denver,CO",
                                    destination: "London,UK",
                                    api_key: user.api_key
                                  })

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)
        expect(json[:data][:attributes][:travel_time]).to eq("impossible")
        expect(json[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end
  end
end