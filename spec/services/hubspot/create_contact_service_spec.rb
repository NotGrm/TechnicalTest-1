# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hubspot::CreateContactService', type: :service do
  describe '#execute' do
    subject(:service) { Hubspot::CreateContactService.new(contact) }

    let(:contact) { FactoryBot.create(:contact) }

    context 'when Hubspot library return a contact' do
      let(:hubspot_contact) { Hubspot::Contact.new('vid' => 201) }

      before do
        allow(Hubspot::Contact).to receive(:create!).and_return(hubspot_contact)

        service.execute
      end

      it 'calls Hubspot library' do
        expect(Hubspot::Contact).to have_received(:create!).with(contact.email,
                                                                 'firstname' => contact.firstname,
                                                                 'lastname' => contact.lastname)
      end

      it 'is a success' do
        expect(service).to be_success
      end

      it 'sets hubspot_contact_id property' do
        expect(service.hubspot_contact_id).to eq(201)
      end
    end

    context 'when Hubspot library raise an error' do
      let(:response) { OpenStruct.new(body: 'there is an error') } # mock net/http response object
      let(:hubspot_error) { Hubspot::RequestError.new response }

      before do
        allow(Hubspot::Contact).to receive(:create!).and_raise(hubspot_error)

        service.execute
      end

      it 'is not a success' do
        expect(service).to_not be_success
      end

      it 'has error message' do
        expect(service.errors).to include('there is an error')
      end
    end
  end
end
