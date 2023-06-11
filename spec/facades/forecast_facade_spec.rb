require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  describe 'instance methods' do
    describe '#forecast' do
      it 'returns a forecast object', :vcr do
        forecast = ForecastFacade.new('denver,co').forecast

        expect(forecast).to be_a(Forecast)
        expect(forecast.current).to be_a(Hash)
        expect(forecast.daily).to be_a(Array)
        expect(forecast.hourly).to be_a(Array)
      end
    end
  end
end