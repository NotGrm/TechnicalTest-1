# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Contacts', type: :request do
  describe 'POST /api/contacts' do
    let(:headers) do
      {
        'ACCEPT' => 'application/json',
        'CONTENT_TYPE' => 'application/json'
      }
    end

    let(:params) do
      {
        contact: {
          email: 'john.doe@example.org',
          lastname: 'doe',
          firstname: 'john'
        }
      }
    end

    let(:json_response) { JSON.parse(response.body, symbolize_names: true) }

    subject(:request) { post '/api/contacts', params: params.to_json, headers: headers }

    it 'returns 201 http status' do
      request

      expect(response).to have_http_status(:created)
    end

    it 'creates a new contact' do
      expect { request }.to change { Contact.count }.by(1)
    end

    it 'returns contact data' do
      request

      expect(json_response.dig(:contact, :id)).to_not be_nil
      expect(json_response.dig(:contact, :email)).to eq('john.doe@example.org')
      expect(json_response.dig(:contact, :lastname)).to eq('doe')
      expect(json_response.dig(:contact, :firstname)).to eq('john')
    end

    context 'when email is missing' do
      let(:params) do
        {
          contact: {
            email: '',
            lastname: 'doe',
            firstname: 'john'
          }
        }
      end

      it 'returns 400 http status' do
        request

        expect(response).to have_http_status(:bad_request)
      end

      it 'returns errors message' do
        request

        expect(json_response[:email]).to include("can't be blank")
      end
    end
  end
end
