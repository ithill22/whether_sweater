require 'rails_helper'

RSpec.describe ImageService do
  describe 'instance methods' do
    describe '#get_image' do
      it 'returns an image for a given location', :vcr do
        service = ImageService.new
        response = service.get_image('denver,co')

        expect(response).to be_a Hash
        
        expect(response).to have_key :results
        expect(response[:results]).to be_a Array

        expect(response[:results].first).to have_key :urls
        expect(response[:results].first[:urls]).to be_a Hash

        expect(response[:results].first[:urls]).to have_key :raw
        expect(response[:results].first[:urls][:raw]).to be_a String

        expect(response[:results].first).to have_key :user
        expect(response[:results].first[:user]).to be_a Hash

        expect(response[:results].first[:user]).to have_key :name
        expect(response[:results].first[:user][:name]).to be_a String

        expect(response[:results].first[:user]).to have_key :profile_image
        expect(response[:results].first[:user][:profile_image]).to be_a Hash
      end
    end
  end
end