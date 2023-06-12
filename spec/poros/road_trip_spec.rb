require 'rails_helper'

RSpec.describe RoadTrip, type: :poro do
  describe '#initialize' do
    it 'exists and has attributes' do
      road_trip = RoadTrip.new(road_trip_data, forecast_data)
    end
  end
end