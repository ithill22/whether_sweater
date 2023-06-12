require 'rails_helper'

RSpec.describe 'User Login API' do
  describe 'Login User' do
    describe 'happy path' do
      it 'logs in a user and returns an api key', :vcr do
        User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                  "email": "test@test.com",
                                  "password": "password"
                                })

        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:data]).to be_a(Hash)

        expect(json[:data]).to have_key(:id)
        expect(json[:data][:id]).to be_a(String)

        expect(json[:data]).to have_key(:type)
        expect(json[:data][:type]).to be_a(String)

        expect(json[:data]).to have_key(:attributes)
        expect(json[:data][:attributes]).to be_a(Hash)

        expect(json[:data][:attributes]).to have_key(:email)
        expect(json[:data][:attributes][:email]).to be_a(String)

        expect(json[:data][:attributes]).to have_key(:api_key)
        expect(json[:data][:attributes][:api_key]).to be_a(String)
      end
    end

    describe 'sad path' do
      it 'returns an error if password does not match', :vcr do
        User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                  "email": "test@test.com",
                                  "password": "password123"
                                })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Email or password not found")
      end

      it 'returns an error if email is incorrect', :vcr do
        User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/sessions', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                                 params: JSON.generate({
                                  "email": "test2@test.com",
                                  "password": "password"
                                })

        expect(response).to_not be_successful
        expect(response.status).to eq(401)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Email or password not found")
      end
    end
  end
end