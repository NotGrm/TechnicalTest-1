# frozen_string_literal: true

module Hubspot
  class CreateContactService
    attr_reader :contact, :hubspot_contact_id

    def initialize(contact)
      @contact = contact
    end

    def execute
      hubspot_contact = Hubspot::Contact.create!(contact.email, contact_params)

      @hubspot_contact_id = hubspot_contact.vid
    rescue Hubspot::RequestError => e
      errors.push e.response.body
    end

    def success?
      errors.empty?
    end

    def errors
      @errors ||= []
    end

    private

    def contact_params
      contact.attributes.slice('firstname', 'lastname')
    end
  end
end
