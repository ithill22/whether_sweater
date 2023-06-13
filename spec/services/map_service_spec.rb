require 'rails_helper'

RSpec.describe MapService do
  describe 'instance methods' do
    describe '#get_coordinates' do
      it 'returns coordinates for a given location', :vcr do
        service = MapService.new
        response = service.get_coordinates('denver,co')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:results)
        expect(response[:results]).to be_an(Array)

        expect(response[:results][0]).to have_key(:locations)
        expect(response[:results][0][:locations]).to be_an(Array)

        expect(response[:results][0][:locations][0]).to have_key(:latLng)
        expect(response[:results][0][:locations][0][:latLng]).to be_a(Hash)

        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lat)
        expect(response[:results][0][:locations][0][:latLng][:lat]).to be_a(Float)

        expect(response[:results][0][:locations][0][:latLng]).to have_key(:lng)
        expect(response[:results][0][:locations][0][:latLng][:lng]).to be_a(Float)
      end
    end

    describe '#get_directions' do
      it 'returns directions for a given origin and destination', :vcr do
        service = MapService.new
        response = service.get_directions('denver,co', 'orlando,fl')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:route)
        expect(response[:route]).to be_a(Hash)

        expect(response[:route]).to have_key(:formattedTime)
        expect(response[:route][:formattedTime]).to be_a(String)

        expect(response[:route]).to have_key(:realTime)
        expect(response[:route][:realTime]).to be_an(Integer)

        expect(response[:route]).to have_key(:legs)
        expect(response[:route][:legs]).to be_an(Array)
      end

      it 'returns an error if a route does not exist', :vcr do
        service = MapService.new
        response = service.get_directions('denver,co', 'london,uk')

        expect(response).to be_a(Hash)
        expect(response).to have_key(:route)
        expect(response[:route]).to be_a(Hash)

        expect(response[:route]).to have_key(:routeError)
        expect(response[:route][:routeError][:errorCode]).to eq(2)
      end
    end
  end
end