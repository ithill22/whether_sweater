require 'rails_helper'

RSpec.describe WeatherService do
  describe 'instance methods' do
    describe '#get_forecast' do
      it 'returns forecast for a city', :vcr do
        service = WeatherService.new
        response = service.get_forecast('39.738453', '-104.984853')

        expect(response).to be_a Hash

        expect(response).to have_key :current
        expect(response[:current]).to be_a Hash

        expect(response[:current]).to have_key :last_updated
        expect(response[:current][:last_updated]).to be_a String

        expect(response[:current]).to have_key :temp_f
        expect(response[:current][:temp_f]).to be_a Float

        expect(response[:current]).to have_key :feelslike_f
        expect(response[:current][:feelslike_f]).to be_a Float

        expect(response[:current]).to have_key :humidity
        expect(response[:current][:humidity]).to be_a Integer

        expect(response[:current]).to have_key :wind_mph
        expect(response[:current][:wind_mph]).to be_a Float

        expect(response[:current]).to have_key :uv
        expect(response[:current][:uv]).to be_a Float

        expect(response[:current]).to have_key :condition
        expect(response[:current][:condition]).to be_a Hash

        expect(response[:current][:condition]).to have_key :text
        expect(response[:current][:condition][:text]).to be_a String

        expect(response[:current][:condition]).to have_key :icon
        expect(response[:current][:condition][:icon]).to be_a String

        expect(response).to have_key :forecast
        expect(response[:forecast]).to be_a Hash

        expect(response[:forecast]).to have_key :forecastday
        expect(response[:forecast][:forecastday]).to be_a Array

        expect(response[:forecast][:forecastday].first).to have_key :date
        expect(response[:forecast][:forecastday].first[:date]).to be_a String

        expect(response[:forecast][:forecastday].first).to have_key :day
        expect(response[:forecast][:forecastday].first[:day]).to be_a Hash

        expect(response[:forecast][:forecastday].first[:day]).to have_key :maxtemp_f
        expect(response[:forecast][:forecastday].first[:day][:maxtemp_f]).to be_a Float

        expect(response[:forecast][:forecastday].first[:day]).to have_key :mintemp_f
        expect(response[:forecast][:forecastday].first[:day][:mintemp_f]).to be_a Float

        expect(response[:forecast][:forecastday].first[:day]).to have_key :avgtemp_f
        expect(response[:forecast][:forecastday].first[:day][:avgtemp_f]).to be_a Float

        expect(response[:forecast][:forecastday].first[:day]).to have_key :maxwind_mph
        expect(response[:forecast][:forecastday].first[:day][:maxwind_mph]).to be_a Float

        expect(response[:forecast][:forecastday].first[:day]).to have_key :totalprecip_in
        expect(response[:forecast][:forecastday].first[:day][:totalprecip_in]).to be_a Float

        expect(response[:forecast][:forecastday].first[:day]).to have_key :condition
        expect(response[:forecast][:forecastday].first[:day][:condition]).to be_a Hash

        expect(response[:forecast][:forecastday].first[:day][:condition]).to have_key :text
        expect(response[:forecast][:forecastday].first[:day][:condition][:text]).to be_a String

        expect(response[:forecast][:forecastday].first[:day][:condition]).to have_key :icon
        expect(response[:forecast][:forecastday].first[:day][:condition][:icon]).to be_a String

        expect(response[:forecast][:forecastday].first).to have_key :hour
        expect(response[:forecast][:forecastday].first[:hour]).to be_a Array

        expect(response[:forecast][:forecastday].first[:hour].first).to have_key :time
        expect(response[:forecast][:forecastday].first[:hour].first[:time]).to be_a String

        expect(response[:forecast][:forecastday].first[:hour].first).to have_key :temp_f
        expect(response[:forecast][:forecastday].first[:hour].first[:temp_f]).to be_a Float

        expect(response[:forecast][:forecastday].first[:hour].first).to have_key :condition
        expect(response[:forecast][:forecastday].first[:hour].first[:condition]).to be_a Hash

        expect(response[:forecast][:forecastday].first[:hour].first[:condition]).to have_key :text
        expect(response[:forecast][:forecastday].first[:hour].first[:condition][:text]).to be_a String

        expect(response[:forecast][:forecastday].first[:hour].first[:condition]).to have_key :icon
        expect(response[:forecast][:forecastday].first[:hour].first[:condition][:icon]).to be_a String
      end

    end
  end
end