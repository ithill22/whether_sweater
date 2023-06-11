require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  describe 'instance methods' do
    describe '#fetch_forecast' do
      it 'returns a forecast object', :vcr do
        facade = ForecastFacade.new
        forecast = facade.fetch_forecast('denver,co')


        expect(forecast).to be_a(Forecast)
      end
    end
  end
end