require 'rails_helper'

RSpec.describe 'User Registration API' do
  describe 'Create User' do
    describe 'happy path' do
      it 'creates a user and returns an api key', :vcr do
        post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }, 
                              params: JSON.generate({
                                "email": "test@test.com",
                                "password": "password",
                                "password_confirmation": "password"
                              })
        
        expect(response).to be_successful
        expect(response.status).to eq(201)

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
      it 'returns an error if passwords do not match', :vcr do
        post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                              params: JSON.generate({
                                "email": "test@test.com",
                                "password": "password",
                                "password_confirmation": "password1"
                              })

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
      end

      it 'returns an error if email is already taken', :vcr do
        User.create!(email: "test@test.com", password: "password", password_confirmation: "password")
        post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                              params: JSON.generate({
                                "email": "test@test.com",
                                "password": "password",
                                "password_confirmation": "password"
                              })

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Validation failed: Email has already been taken")
      end

      it 'returns an error if email is missing', :vcr do
        post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                              params: JSON.generate({
                                "password": "password",
                                "password_confirmation": "password"
                              })

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Validation failed: Email can't be blank")
      end

      it 'returns an error if password is missing', :vcr do
        post '/api/v1/users', headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' },
                              params: JSON.generate({
                                "email": "test@test.com",
                                "password": "",
                                "password_confirmation": "password"
                              })
                      
        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to be_a(Hash)
        expect(json[:errors][:detail]).to eq("Validation failed: Password can't be blank, Password can't be blank")
      end
    end
  end
end