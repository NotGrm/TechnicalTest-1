# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'Methods' do
    let(:contact) { FactoryBot.build(:contact) }

    describe '#email=' do
      it 'downcases email address when set' do
        contact.email = 'TEST@eXample.org'
        expect(contact.email).to eq('test@example.org')
      end
    end

    describe '#lastname=' do
      it 'downcases lastname when set' do
        contact.lastname = 'DOe'
        expect(contact.lastname).to eq('doe')
      end
    end

    describe '#firstname=' do
      it 'downcases firstname address when set' do
        contact.firstname = 'jOHn'
        expect(contact.firstname).to eq('john')
      end
    end
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { is_expected.to validate_presence_of(:lastname) }
    it { is_expected.to validate_length_of(:lastname).is_at_least(2) }

    it { is_expected.to validate_presence_of(:firstname) }
    it { is_expected.to validate_length_of(:firstname).is_at_least(2) }

    describe 'email format validation' do
      subject { FactoryBot.build(:contact, email: email) }

      context 'when is a valid email address' do
        let(:email) { 'test@example.org' }

        it { is_expected.to be_valid }
      end

      context 'when is not a valid email address' do
        let(:email) { 'a' * 10 }

        it { is_expected.to_not be_valid }
      end
    end
  end
end
