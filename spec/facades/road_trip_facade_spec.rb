require 'rails_helper'

RSpec.describe 'Road Trip Facade' do
  describe 'instance methods' do
    describe '#road_trip' do
      it 'returns a road trip object', :vcr do
        user = User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        road_trip = RoadTripFacade.new('Denver,CO', 'Orlando,FL', user.api_key).road_trip

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:condition]).to be_a(String)
      end
    end
  end
end