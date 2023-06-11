require 'rails_helper'

RSpec.describe Forecast, type: :poro do
  before :each do
    forecast_data
  end
  describe '#initialize' do
    it 'exists and has attributes' do
      forecast = Forecast.new(forecast_data)

      expect(forecast).to be_a(Forecast)
      expect(forecast.current).to be_a(Hash)
      expect(forecast.daily).to be_a(Array)
      expect(forecast.hourly).to be_a(Array)
    end
  end
end

           
