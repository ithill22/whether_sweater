require 'rails_helper'

RSpec.describe Coordinates, type: :poro do
  describe '#initialize' do
    it 'exists and has attributes' do
      coord_data = {
        results: [
          locations: [
            { latLng: 
              { lat: 39.738453, lng: -104.984853 } 
            }]]}
      coordinates = Coordinates.new(coord_data)

      expect(coordinates).to be_a(Coordinates)
      expect(coordinates.lat).to eq(39.738453)
      expect(coordinates.lng).to eq(-104.984853)
    end
  end
end