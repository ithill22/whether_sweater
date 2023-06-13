require 'rails_helper'

RSpec.describe RoadTrip, type: :poro do
  describe '#initialize' do
    it 'exists and has attributes', :vhs do
      VCR.use_cassette('road_trip_poro') do
        origin = 'Denver,CO'
        destination = 'Pueblo,CO'
        road_trip_data = MapService.new.get_directions(origin, destination)
        forecast_data = Forecast.new(WeatherService.new.get_forecast(39.738453, -104.984853))

        road_trip = RoadTrip.new(origin, destination, road_trip_data, forecast_data)

        expect(road_trip).to be_a(RoadTrip)
        expect(road_trip.start_city).to eq(origin)
        expect(road_trip.end_city).to eq(destination)
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta[:datetime]).to be_a(String)
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:condition]).to be_a(String)
      end 
    end
  end
end