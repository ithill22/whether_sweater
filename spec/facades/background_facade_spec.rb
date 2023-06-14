require 'rails_helper'

RSpec.describe 'Background Facade' do
  describe 'instance methods' do
    describe '#background' do
      it 'returns a background object', :vcr do
        background = BackgroundFacade.new('denver,co').background

        expect(background).to be_a(Image)
        expect(background.image_url).to be_a(String)
        expect(background.credit).to be_a(Hash)
        expect(background.credit[:source]).to be_a(String)
        expect(background.credit[:author]).to be_a(String)
        expect(background.credit[:logo]).to be_a(String)
        expect(background.location).to be_a(String)
        expect(background.id).to eq(nil)
      end
    end
  end
end