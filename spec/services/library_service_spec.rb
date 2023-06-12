require 'rails_helper'

RSpec.describe LibraryService do
  describe 'instance methods' do
    describe '#get_books' do
      it 'returns books for a search term', :vcr do
        service = LibraryService.new
        response = service.get_books('denver,co')

        expect(response).to be_a Hash

        expect(response).to have_key :numFound
        expect(response[:numFound]).to be_a Integer

        expect(response).to have_key :docs
        expect(response[:docs]).to be_a Array

        expect(response[:docs].first).to have_key :title
        expect(response[:docs].first[:title]).to be_a String

        expect(response[:docs].first).to have_key :isbn
        expect(response[:docs].first[:isbn]).to be_a Array

        expect(response[:docs].first).to have_key :publisher
        expect(response[:docs].first[:publisher]).to be_a Array
      end
    end
  end
end