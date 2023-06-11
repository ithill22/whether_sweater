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
  end
end