require 'rails_helper'

RSpec.describe CoordinatesFacade do
  describe 'instance methods' do
    describe '#fetch_coordinates' do
      it 'returns coordinates for a given location', :vcr do
        facade = CoordinatesFacade.new
        coordinates = facade.fetch_coordinates('denver,co')

        expect(coordinates).to be_a(Coordinates)
      end
    end
  end
end