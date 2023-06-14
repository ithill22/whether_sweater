require 'rails_helper'

RSpec.describe Image, type: :poro do
  let(:location) { 'denver,co' }
  let(:image_data) do
    {
      results: [
        {
          urls: { raw: 'https://example.com/image.jpg' },
          links: { html: 'https://example.com/source' },
          user: {
            name: 'John Doe',
            profile_image: { small: 'https://example.com/logo.jpg' }
          }
        }
      ]
    }
  end

  subject { Image.new(location, image_data) }

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(subject).to be_a(Image)
      expect(subject.id).to eq(nil)
      expect(subject.location).to eq(location)
      expect(subject.image_url).to eq(image_data[:results][0][:urls][:raw])
      expect(subject.credit).to be_a(Hash)
      expect(subject.credit[:source]).to eq(image_data[:results][0][:links][:html])
      expect(subject.credit[:author]).to eq(image_data[:results][0][:user][:name])
      expect(subject.credit[:logo]).to eq(image_data[:results][0][:user][:profile_image][:small])
    end
  end
end