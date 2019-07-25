# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Hubspot::CreateEngagmentNoteService', type: :service do
  describe '#execute' do
    subject(:service) { Hubspot::CreateEngagmentNoteService.new(contact, 'a message') }

    let(:contact) { FactoryBot.create(:contact, hubspot_id: 301) }

    context 'when Hubspot library return a note' do
      before do
        allow(Hubspot::EngagementNote).to receive(:create!)

        service.execute
      end

      it 'calls Hubspot library' do
        expect(Hubspot::EngagementNote).to have_received(:create!).with(301, 'a message')
      end

      it 'is a success' do
        expect(service).to be_success
      end
    end

    context 'when Hubspot library raise an error' do
      let(:response) { OpenStruct.new(body: 'there is an error') } # mock net/http response object
      let(:hubspot_error) { Hubspot::RequestError.new response }

      before do
        allow(Hubspot::EngagementNote).to receive(:create!).and_raise(hubspot_error)

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
